#!/bin/bash
set -euo pipefail

printf '%b' '\033[1;33mTMUX QUICK HELP\033[0m

\033[1mSessions\033[0m
  Prefix + S    Open session manager popup
  Prefix + N    Create or jump to a named session
  Prefix + R    Rename the current session

\033[1mNavigation\033[0m
  Prefix + f    Search panes across all sessions
  Alt + H/L     Previous or next window
  Shift + Alt + Left/Right
                Reorder windows

\033[1mWindows and Panes\033[0m
  Prefix + c    New window in current directory
  Prefix + "    Split pane vertically in current directory
  Prefix + %    Split pane horizontally in current directory

\033[1mInside Session Manager\033[0m
  Enter         Switch to selected session
  Ctrl + n      Prompt for a new session name
  Ctrl + r      Prompt to rename selected session
  Ctrl + k      Kill selected session after confirmation

\033[1mInside Pane Search\033[0m
  Type to filter by "session > folder"
  Enter         Jump directly to the pane

\033[1mClose\033[0m
  q or Esc      Exit this help popup
'
