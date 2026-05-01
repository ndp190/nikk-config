#!/bin/bash
set -euo pipefail

interval="${TMUX_AUTOSAVE_INTERVAL:-}"

require_tmux() {
  if ! command -v tmux >/dev/null 2>&1; then
    echo "tmux is required" >&2
    exit 1
  fi
}

tmux_option() {
  local option_name="$1"
  tmux show-options -gqv "$option_name" 2>/dev/null || true
}

autosave_interval() {
  local option_value
  option_value="$(tmux_option @tmux-autosave-interval)"

  if [[ -n "$interval" ]]; then
    printf '%s\n' "$interval"
  elif [[ -n "$option_value" ]]; then
    printf '%s\n' "$option_value"
  else
    printf '10\n'
  fi
}

socket_lock_dir() {
  local socket_path socket_hash
  socket_path="$(tmux display-message -p '#{socket_path}' 2>/dev/null || printf '%s' default)"
  socket_hash="$(printf '%s' "$socket_path" | cksum | awk '{print $1}')"
  printf '%s\n' "${TMPDIR:-/tmp}/tmux-resurrect-autosave-${socket_hash}.lock"
}

save_script_path() {
  printf '%s\n' "$HOME/.tmux/plugins/tmux-resurrect/scripts/save.sh"
}

save_once() {
  local save_script
  save_script="$(save_script_path)"

  [[ -x "$save_script" ]] || return 0
  "$save_script" >/dev/null 2>&1 || true
}

watch() {
  local lock_dir seconds
  lock_dir="$(socket_lock_dir)"
  seconds="$(autosave_interval)"

  if ! [[ "$seconds" =~ ^[0-9]+$ ]] || [[ "$seconds" -lt 1 ]]; then
    seconds=10
  fi

  if ! mkdir "$lock_dir" 2>/dev/null; then
    exit 0
  fi

  trap 'rmdir "$lock_dir" >/dev/null 2>&1 || true' EXIT INT TERM

  save_once
  while tmux list-panes >/dev/null 2>&1; do
    sleep "$seconds"
    save_once
  done
}

require_tmux
watch
