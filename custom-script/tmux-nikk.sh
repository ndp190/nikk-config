#!/bin/bash

tmux new-session -d -n "dashboard" -s "nikk" # create new session , detached
# tmux send-keys -t 0 "glances" Enter # this actually launches `glances` in my first window

# tmux new-window -n "two"
tmux split-window -h # split it into two halves
tmux resize-pane -x 95
tmux split-window -v -p 30 # split it into two halves
tmux resize-pane -x 80
tmux resize-pane -y 20

tmux send-keys -t 0 "newsboat" Enter # bonsai for second pane
tmux send-keys -t 1 "wtfutil" Enter # bonsai for second pane
tmux send-keys -t 2 "cbonsai -li -t 0.1" Enter # bonsai for second pane

tmux select-pane -t 0 # go back to the first pane

# tmux new-window -n "three"
# tmux split-window -h -p 30 # split it into two halves
# tmux select-pane -t 0 # go back to the first pane
# tmux send-keys -t 0 "cd work" Enter # change to specific subdir for these two panes
# tmux send-keys -t 1 "cd work" Enter

# etc..you can keep adding more new windows as needed..

# sleep 1 # not sure why I had this...

# tmux select-window -t "nikk:dashboard" # go back to the first window
tmux attach-session -d
