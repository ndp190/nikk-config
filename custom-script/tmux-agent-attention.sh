#!/bin/bash
set -euo pipefail

scan_interval="${TMUX_AGENT_ATTENTION_INTERVAL:-2}"
watch_pattern='^(claude|codex)$'

require_tmux() {
  if ! command -v tmux >/dev/null 2>&1; then
    echo "tmux is required" >&2
    exit 1
  fi
}

option_value() {
  local pane_id="$1"
  local option_name="$2"
  tmux show-options -pt "$pane_id" -v "$option_name" 2>/dev/null || true
}

set_option() {
  local pane_id="$1"
  local option_name="$2"
  local option_value="$3"
  tmux set-option -pt "$pane_id" "$option_name" "$option_value" >/dev/null
}

unset_option() {
  local pane_id="$1"
  local option_name="$2"
  tmux set-option -pt "$pane_id" -u "$option_name" >/dev/null 2>&1 || true
}

pane_label() {
  local pane_id="$1"
  tmux display-message -p -t "$pane_id" '#{session_name} > #{b:pane_current_path}' 2>/dev/null
}

apple_escape() {
  printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'
}

notify_attention() {
  local source_name="$1"
  local pane_id="$2"
  local label escaped_label escaped_title
  label="$(pane_label "$pane_id")"
  [[ -n "$label" ]] || label="$pane_id"

  tmux display-message "${source_name} needs input: ${label}" >/dev/null 2>&1 || true

  if command -v osascript >/dev/null 2>&1; then
    escaped_label="$(apple_escape "$label")"
    escaped_title="$(apple_escape "${source_name} needs input")"
    osascript -e "display notification \"${escaped_label}\" with title \"${escaped_title}\"" >/dev/null 2>&1 || true
  fi
}

normalize_source() {
  case "$1" in
    claude) printf '%s\n' "Claude Code" ;;
    codex) printf '%s\n' "Codex CLI" ;;
    *) printf '%s\n' "$1" ;;
  esac
}

fingerprint_text() {
  cksum | awk '{print $1}'
}

capture_text() {
  local pane_id="$1"
  tmux capture-pane -p -t "$pane_id" -S -120 2>/dev/null || true
}

detect_attention() {
  local pane_id="$1"
  local source_name="$2"
  local capture summary matched fingerprint

  capture="$(capture_text "$pane_id")"
  [[ -n "$capture" ]] || return 1

  matched="$(printf '%s\n' "$capture" | awk '
    /Do you want to allow/ { line=$0 }
    /Allow once/ { line=$0 }
    /Allow always/ { line=$0 }
    /Deny/ { line=$0 }
    /Press Enter to continue/ { line=$0 }
    /Waiting for your input/ { line=$0 }
    /waiting for input/ { line=$0 }
    /Select an option/ { line=$0 }
    /Approve/ { line=$0 }
    /approval required/ { line=$0 }
    /PermissionRequest/ { line=$0 }
    END {
      if (line != "") {
        print line
      }
    }
  ')"

  [[ -n "$matched" ]] || return 1

  summary="$(printf '%s' "$matched" | tr '\n' ' ' | sed 's/  */ /g' | cut -c1-120)"
  fingerprint="$(printf '%s\n%s\n' "$source_name" "$matched" | fingerprint_text)"
  printf '%s\t%s\n' "$fingerprint" "$summary"
}

mark_attention() {
  local source_name="$1"
  local pane_id="$2"
  local fingerprint="${3:-manual}"
  local summary="${4:-needs input}"
  local existing seen

  existing="$(option_value "$pane_id" @agent_attention_fingerprint)"
  seen="$(option_value "$pane_id" @agent_attention_seen)"

  if [[ "$existing" == "$fingerprint" || "$seen" == "$fingerprint" ]]; then
    return 0
  fi

  set_option "$pane_id" @agent_attention "$source_name"
  set_option "$pane_id" @agent_attention_fingerprint "$fingerprint"
  set_option "$pane_id" @agent_attention_summary "$summary"
  notify_attention "$(normalize_source "$source_name")" "$pane_id"
}

clear_attention() {
  local pane_id="$1"
  local fingerprint

  fingerprint="$(option_value "$pane_id" @agent_attention_fingerprint)"
  if [[ -n "$fingerprint" ]]; then
    set_option "$pane_id" @agent_attention_seen "$fingerprint"
  fi

  unset_option "$pane_id" @agent_attention
  unset_option "$pane_id" @agent_attention_fingerprint
  unset_option "$pane_id" @agent_attention_summary
}

scan_pane() {
  local pane_id="$1"
  local source_name="$2"
  local detection fingerprint summary

  detection="$(detect_attention "$pane_id" "$source_name" || true)"
  if [[ -n "$detection" ]]; then
    fingerprint="$(printf '%s\n' "$detection" | cut -f1)"
    summary="$(printf '%s\n' "$detection" | cut -f2-)"
    mark_attention "$source_name" "$pane_id" "$fingerprint" "$summary"
  else
    unset_option "$pane_id" @agent_attention_seen
    unset_option "$pane_id" @agent_attention
    unset_option "$pane_id" @agent_attention_fingerprint
    unset_option "$pane_id" @agent_attention_summary
  fi
}

scan_once() {
  local format pane_id source_name pane_dead
  format=$'#{pane_id}\t#{pane_current_command}\t#{pane_dead}'

  tmux list-panes -a -F "$format" | while IFS=$'\t' read -r pane_id source_name pane_dead; do
    [[ "$pane_dead" == "1" ]] && continue

    if [[ "$source_name" =~ $watch_pattern ]]; then
      scan_pane "$pane_id" "$source_name"
    else
      unset_option "$pane_id" @agent_attention_seen
      unset_option "$pane_id" @agent_attention
      unset_option "$pane_id" @agent_attention_fingerprint
      unset_option "$pane_id" @agent_attention_summary
    fi
  done
}

watch_lock_dir() {
  local socket_path socket_hash
  socket_path="$(tmux display-message -p '#{socket_path}' 2>/dev/null || printf '%s' default)"
  socket_hash="$(printf '%s' "$socket_path" | cksum | awk '{print $1}')"
  printf '%s\n' "${TMPDIR:-/tmp}/tmux-agent-attention-${socket_hash}.lock"
}

watch() {
  local lock_dir
  lock_dir="$(watch_lock_dir)"

  if ! mkdir "$lock_dir" 2>/dev/null; then
    exit 0
  fi

  trap 'rmdir "$lock_dir" >/dev/null 2>&1 || true' EXIT INT TERM

  while tmux list-panes >/dev/null 2>&1; do
    scan_once
    sleep "$scan_interval"
  done
}

hook_mark() {
  local source_name="${1:?missing source}"
  local pane_id detection fingerprint summary candidate_arg="${2:-}"

  if [[ "$candidate_arg" == %* ]]; then
    pane_id="$candidate_arg"
  else
    pane_id="$(tmux display-message -p "#{pane_id}" 2>/dev/null || true)"
  fi
  [[ -n "$pane_id" ]] || exit 0

  detection="$(detect_attention "$pane_id" "$source_name" || true)"
  if [[ -n "$detection" ]]; then
    fingerprint="$(printf '%s\n' "$detection" | cut -f1)"
    summary="$(printf '%s\n' "$detection" | cut -f2-)"
  else
    fingerprint="${source_name}-hook"
    summary="needs input"
  fi

  mark_attention "$source_name" "$pane_id" "$fingerprint" "$summary"
}

main() {
  require_tmux

  case "${1:-watch}" in
    watch)
      watch
      ;;
    scan-once)
      scan_once
      ;;
    hook)
      hook_mark "${2:?missing source}" "${3:-}"
      ;;
    mark)
      mark_attention "${2:?missing source}" "${3:?missing pane id}" "${4:-manual}" "${5:-needs input}"
      ;;
    clear)
      clear_attention "${2:?missing pane id}"
      ;;
    *)
      echo "usage: $0 [watch|scan-once|hook SOURCE [PANE]|mark SOURCE PANE [FINGERPRINT] [SUMMARY]|clear PANE]" >&2
      exit 1
      ;;
  esac
}

main "$@"
