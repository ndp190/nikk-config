#!/bin/bash
set -euo pipefail

fzf_bin="${FZF_BIN:-$(command -v fzf || true)}"

require_tmux() {
  if ! command -v tmux >/dev/null 2>&1; then
    echo "tmux is required" >&2
    exit 1
  fi
}

pane_rows() {
  local target_session="$1"
  local format
  format=$'#{session_name}\t#{window_index}\t#{window_name}\t#{pane_id}\t#{pane_current_path}\t#{pane_active}'
  tmux list-panes -a -F "$format" |
    awk -F '\t' -v target_session="$target_session" '
      target_session == "" || $1 == target_session {
        n = split($5, parts, "/")
        pane_name = parts[n]
        if (pane_name == "") {
          pane_name = "/"
        }
        active = ($6 == "1") ? "*" : " "
        label = sprintf("%s > %s", $1, pane_name)
        context = sprintf("%s:%s  %s  %s", $1, $2, $3, active)
        print label "\t" context "\t" $4 "\t" $5
      }
    '
}

jump_to_pane() {
  local session_name="$1"
  local pane_id="$2"
  if [[ -n "${TMUX:-}" ]]; then
    tmux switch-client -t "$session_name"
  elif [[ -t 0 && -t 1 ]]; then
    tmux attach-session -t "$session_name"
  fi
  tmux select-pane -t "$pane_id"
}

interactive() {
  require_tmux
  if [[ -z "$fzf_bin" ]]; then
    echo "fzf is required for interactive mode" >&2
    exit 1
  fi

  local session_name selected pane_id target_session
  target_session="${1:-}"

  selected="$(
    pane_rows "$target_session" | "$fzf_bin" \
      --ansi \
      --border=rounded \
      --height=100% \
      --layout=reverse \
      --prompt="Panes > " \
      --header="enter jump  esc close" \
      --delimiter=$'\t' \
      --with-nth=1,2,4 \
      --preview 'tmux capture-pane -p -t {3} -S -20' \
      --preview-window=right,65%,border-left
  )"

  [[ -n "$selected" ]] || exit 0

  session_name="$(printf '%s\n' "$selected" | cut -f1 | sed 's/ > .*//')"
  pane_id="$(printf '%s\n' "$selected" | cut -f3)"
  jump_to_pane "$session_name" "$pane_id"
}

main() {
  case "${1:-interactive}" in
    interactive)
      interactive "${2:-}"
      ;;
    list)
      require_tmux
      pane_rows "${2:-}"
      ;;
    jump)
      require_tmux
      jump_to_pane "${2:?missing session name}" "${3:?missing pane id}"
      ;;
    *)
      echo "usage: $0 [interactive [SESSION]|list [SESSION]|jump SESSION PANE_ID]" >&2
      exit 1
      ;;
  esac
}

main "$@"
