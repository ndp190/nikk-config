# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "/Users/phuc.nguyen/Projects/nikk"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "side"; then

  # run_cmd "nvim"
  # split_v 10
  # run_cmd "pnpm dev"
  new_window "task"
  run_cmd "taskwarrior-tui -r side"
  new_window "editor"

  select_window 1
  select_pane 1
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
