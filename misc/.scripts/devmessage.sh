#! /bin/bash

tmux new-session -d 'devmessage'
tmux new-window 'docker-compose up'
tmux new-window ''
tmux new-window ''
tmux -2 attach-session -d
