#!/bin/bash
set -euo pipefail

fzf_bin="${FZF_BIN:-$(command -v fzf || true)}"

shell_quote() {
  printf "'%s'" "${1//\'/\'\\\'\'}"
}

require_tmux() {
  if ! command -v tmux >/dev/null 2>&1; then
    echo "tmux is required" >&2
    exit 1
  fi
}

current_path() {
  tmux display-message -p "#{pane_current_path}" 2>/dev/null || pwd
}

list_sessions() {
  local format
  format=$'#{session_name}\t#{session_windows}\t#{?session_attached,attached,detached}'
  tmux list-sessions -F "$format"
}

switch_session() {
  local target="$1"
  if [[ -n "${TMUX:-}" ]]; then
    tmux switch-client -t "$target"
  elif [[ -t 0 && -t 1 ]]; then
    tmux attach-session -t "$target"
  fi
}

new_session() {
  local target="$1"
  tmux new-session -Ad -s "$target" -c "$(current_path)"
  switch_session "$target"
}

rename_session() {
  local new_name="$1"
  local target="${2:-$(tmux display-message -p '#S')}"
  tmux rename-session -t "$target" "$new_name"
}

kill_session() {
  local target="$1"
  tmux kill-session -t "$target"
}

interactive() {
  require_tmux
  if [[ -z "$fzf_bin" ]]; then
    echo "fzf is required for interactive mode" >&2
    exit 1
  fi

  local selected key session_name
  selected="$(
    list_sessions | "$fzf_bin" \
      --ansi \
      --border=rounded \
      --height=100% \
      --layout=reverse \
      --prompt="Sessions > " \
      --header=$'enter switch  ctrl-n new  ctrl-r rename  ctrl-k kill  esc close' \
      --delimiter=$'\t' \
      --with-nth=1,2,3 \
      --expect=enter,ctrl-n,ctrl-r,ctrl-k
  )"

  [[ -n "$selected" ]] || exit 0

  key="$(printf '%s\n' "$selected" | sed -n '1p')"
  session_name="$(printf '%s\n' "$selected" | sed -n '2p' | cut -f1)"

  case "$key" in
    ctrl-n)
      tmux command-prompt -p "New session name" "new-session -A -s '%%' -c '#{pane_current_path}'"
      ;;
    ctrl-r)
      tmux command-prompt -I "$session_name" -p "Rename session" "rename-session -t $(shell_quote "$session_name") '%%'"
      ;;
    ctrl-k)
      tmux confirm-before -p "Kill session $session_name? (y/n)" "kill-session -t $(shell_quote "$session_name")"
      ;;
    enter|"")
      switch_session "$session_name"
      ;;
  esac
}

main() {
  case "${1:-interactive}" in
    interactive)
      interactive
      ;;
    list)
      require_tmux
      list_sessions
      ;;
    new)
      require_tmux
      new_session "${2:?missing session name}"
      ;;
    rename)
      require_tmux
      rename_session "${2:?missing new session name}" "${3:-}"
      ;;
    switch)
      require_tmux
      switch_session "${2:?missing session name}"
      ;;
    kill)
      require_tmux
      kill_session "${2:?missing session name}"
      ;;
    *)
      echo "usage: $0 [interactive|list|new NAME|rename NAME [TARGET]|switch NAME|kill NAME]" >&2
      exit 1
      ;;
  esac
}

main "$@"
