#!/bin/bash

SESSION=$USER

tmux -2 new-session -d -s $SESSION
# Setup a window for tailing log files
tmux new-window -t $SESSION:0 -n 'htop'
tmux new-window -t $SESSION:1 -n 'core'
tmux new-window -t $SESSION:2 -n 'terrain'
tmux new-window -t $SESSION:3 -n 'move_base'
tmux new-window -t $SESSION:4 -n 'navigation'


tmux select-window -t $SESSION:0
tmux send-keys "htop" C-m

tmux select-window -t $SESSION:1
tmux send-keys "roslaunch mongodb_store mongodb_store.launch db_path:=/home/administrator/mongos/rusty"

tmux select-window -t $SESSION:2
tmux send-keys "roslaunch rusty_simulation terrain.launch"

tmux select-window -t $SESSION:3
tmux send-keys "roslaunch husky_navigation move_base_mapless_demo.launch"

tmux select-window -t $SESSION:4
tmux send-keys "roslaunch rusty_simulation rusty_nav.launch topological_map:=rusty_demo"


# Set default window
tmux select-window -t $SESSION:0

# Attach to session
tmux -2 attach-session -t $SESSION

tmux setw -g mode-mouse off