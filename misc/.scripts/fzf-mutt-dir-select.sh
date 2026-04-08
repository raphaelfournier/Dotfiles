#!/usr/bin/env bash

# Option A: Use fzf-marks (if installed)
#dir=$(marks | fzf | awk '{print $NF}')
dir=$(cut -d':' -f2- ~/.fzf-marks | fzf | xargs)

# Option B: Use a hardcoded list of your common save folders
# dir=$(printf "/home/user/Downloads\n/home/user/Documents\n/home/user/Work" | fzf)

# Option C: Use fd to find all directories in your home (slower)
# dir=$(fd --type d --max-depth 2 . $HOME | fzf)

# If a directory was selected, "push" the keystrokes back to Mutt
if [ -n "$dir" ]; then
    # We push: <kill-line>, the directory path, <enter>, and 't' for "tous/all"
    echo "push \"s<kill-line>$dir/<enter>t"
fi
