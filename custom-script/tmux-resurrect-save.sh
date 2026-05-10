#!/bin/bash
set -euo pipefail

save_script="$HOME/.tmux/plugins/tmux-resurrect/scripts/save.sh"
save_mode="${1:-notify}"
active_lock_dir=""

tmux_socket_hash() {
  local socket_path
  socket_path="$(tmux display-message -p '#{socket_path}' 2>/dev/null || printf '%s' default)"
  printf '%s' "$socket_path" | cksum | awk '{print $1}'
}

lock_dir() {
  printf '%s\n' "${TMPDIR:-/tmp}/tmux-resurrect-save-$(tmux_socket_hash).lock"
}

lock_is_stale() {
  local dir="$1" mtime now
  mtime="$(stat -f %m "$dir" 2>/dev/null || stat -c %Y "$dir" 2>/dev/null || printf '0')"
  now="$(date +%s)"
  [[ "$mtime" =~ ^[0-9]+$ ]] && (( now - mtime > 120 ))
}

acquire_lock() {
  local dir="$1"

  for _ in {1..300}; do
    if mkdir "$dir" 2>/dev/null; then
      active_lock_dir="$dir"
      trap 'rmdir "$active_lock_dir" >/dev/null 2>&1 || true' EXIT
      trap 'rmdir "$active_lock_dir" >/dev/null 2>&1 || true; exit 0' INT TERM
      return 0
    fi

    if lock_is_stale "$dir"; then
      rmdir "$dir" >/dev/null 2>&1 || true
    fi

    sleep 0.1
  done

  return 1
}

[[ -x "$save_script" ]] || exit 0

save_lock_dir="$(lock_dir)"
acquire_lock "$save_lock_dir" || exit 0
"$save_script" quiet

if [[ "$save_mode" != "quiet" ]]; then
  tmux display-message -d 700 'tmux saved' >/dev/null 2>&1 || true
fi
