#!/bin/sh
tmux new-session -d 'sleep 0.05s ; mutt -F ~/.muttrc'
tmux -2 attach-session -d # -2 pour 256colors
