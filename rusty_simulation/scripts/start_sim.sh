#!/bin/bash

SESSION=$USER

tmux -2 new-session -d -s $SESSION
# Setup a window for tailing log files
tmux new-window -t $SESSION:0 -n 'roscore'
tmux new-window -t $SESSION:1 -n 'core'
tmux new-window -t $SESSION:2 -n 'robot'
tmux new-window -t $SESSION:3 -n 'terrain'
tmux new-window -t $SESSION:4 -n 'move_base'
tmux new-window -t $SESSION:5 -n 'navigation'


tmux select-window -t $SESSION:0
tmux split-window -v
tmux select-pane -t 0
tmux send-keys "roscore" C-m
tmux resize-pane -U 30
tmux select-pane -t 1
tmux send-keys "htop" C-m

tmux select-window -t $SESSION:1
tmux send-keys "DISPLAY=:0 roslaunch mongodb_store mongodb_store.launch db_path:=/home/jaime/mongos/rusty"

tmux select-window -t $SESSION:2
tmux send-keys "DISPLAY=:0 roslaunch husky_gazebo husky_empty_world.launch"

tmux select-window -t $SESSION:3
tmux send-keys "DISPLAY=:0 roslaunch rusty_simulation terrain.launch"

tmux select-window -t $SESSION:4
tmux send-keys "DISPLAY=:0 roslaunch husky_navigation move_base_mapless_demo.launch"

tmux select-window -t $SESSION:5
tmux send-keys "DISPLAY=:0 roslaunch rusty_simulation rusty_nav.launch topological_map:=rusty_sim"


# Set default window
tmux select-window -t $SESSION:0

# Attach to session
tmux -2 attach-session -t $SESSION

tmux setw -g mode-mouse off