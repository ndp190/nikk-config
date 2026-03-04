# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/Projects/go1"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "go1"; then
  new_window "task"
  run_cmd "taskwarrior-tui -r go1"
  split_h 50
  run_cmd "wtfutil"
  split_v 50
  run_cmd "mo status"
  select_pane 1
  split_v 50
  run_cmd "cd ~/Projects/nikk/nikk-assistant && claudeOp"
  select_pane 1

  new_window "editor"
  select_window 2
  select_pane 1
  # run_cmd "vim"
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
