#!/bin/bash

# set -x

# If there's a single service stoped, then
if [[ $(dinghy status | grep stopped) ]]; then
    dinghy restart
fi

# Clear rbenv variables before starting tmux
unset RBENV_VERSION
unset RBENV_DIR

tmux start-server;

project_directory=$(cd ~/code && pwd)

#Update the repositories when starting
$project_directory/update_repos.sh

TMUX= tmux new-session -d -s instructure -n first_window -x 238 -y 60

# My TMUX is configured to start with the 1 number on windows
count=1
for project in $(ls -1 $project_directory); do
    if [ -d "$project_directory/$project" ]; then
        # Unfortunately the first window is named already :-/
        if [ $count = 1 ]; then
            tmux rename-window -t first_window $project
            # The first window will also be in a different working directory
            tmux send-keys -t instructure:$count.1 cd\ $project_directory/$project C-m
        else
            # Create a Window "$project"
            tmux new-window -c $project_directory/$project -t instructure:$count -n $project
        fi
        
        # Open VIM in the "main" panel
        tmux send-keys -t instructure:$count.1 vim

        # Split the Vim panel in 2, new panel is 80 columns
        tmux split-window -c $project_directory/$project -t instructure:$count.1 -h -l 80

        # Split the 80x60 panel in two new panel should 40 (as it gets later splited in 2)
        tmux split-window -c $project_directory/$project -t instructure:$count.2 -v -l 40

        # Split the 40row panel in two
        tmux split-window -c $project_directory/$project -t instructure:$count.3 -v -l 20

        # Split the "vim" pane adding a console at the bottom
        tmux split-window -c $project_directory/$project -t instructure:$count.1 -v -l 20

        let count=$count+1
    fi
done

# Add the stats window
tmux new-window -c $project_directory/$project -t instructure:$count -n stats
tmux send-keys -t instructure:$count.1 docker\ stats C-m
tmux split-window -c $project_directory/$project -t instructure:$count -v -l 20
tmux send-keys -t instructure:$count.2 top\ -o\ cpu

# Switch to first window
tmux select-window -t instructure:1
# And switch to first pane
tmux select-pane -t instructure:1.1

if [ -z "$TMUX" ]; then
    tmux -u attach-session -t instructure
else
    tmux -u switch-client -t instructure
fi

