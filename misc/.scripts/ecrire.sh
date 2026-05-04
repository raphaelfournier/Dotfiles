#!/bin/bash

# --- Configuration ---
SESSION_NAME="writing_session"
CHAPTERS_DIR="/home/raph/Recherche/Articles/EnCours/IA-universite/Manuscrit/src/chapters/" # Change this to your actual path
EXT="tex"                  # Change to your file extension (e.g., tex, org)
TERMINAL="alacritty"
TIMESTAMP=`date +%y%m%dT%H%M%S`

# --- Logic to handle Rofi/Launcher execution ---
# If STDIN is not a terminal, it means we likely clicked it in a menu.
if [ ! -t 0 ]; then
    # Launch Alacritty and tell it to execute this same script
    # We use 'nohup' so the terminal doesn't die if the launcher closes
    nohup $TERMINAL -e "$0" >/dev/null 2>&1 &
    exit 0
fi

# --- Tmux Session Setup ---
# Check if the session already exists to avoid errors
tmux has-session -t "$SESSION_NAME" 2>/dev/null

if [ $? != 0 ]; then
    # 1. Create the session and windows
    tmux new-session -d -s "$SESSION_NAME" -n "write"
    tmux new-window -t "$SESSION_NAME" -n "compile"
    tmux new-window -t "$SESSION_NAME" -n "view"

    # 2. Set directory and launch fzf/vim
    tmux send-keys -t "$SESSION_NAME:write" "cd '$CHAPTERS_DIR'" C-m
    #tmux send-keys -t "$SESSION_NAME:write" \
        #"selected=\$(find . -name '*.$EXT' | sed 's|^\./||' | fzf) && [ -n \"\$selected\" ] && vim \"\$selected\"" C-m
    tmux send-keys -t "$SESSION_NAME:write" \
        "choice=\$( (printf \" [NEW FILE]\n\"; find . -name '*.$EXT' | sed 's|^\./||') | fzf --header='Select a chapter or create new') && \
        if [ \"\$choice\" = \" [NEW FILE]\" ]; then \
            new_file=\"${TIMESTAMP}.$EXT\"; touch \"\$new_file\"; vim \"\$new_file\"; \
        elif [ -n \"\$choice\" ]; then \
            vim \"\$choice\"; \
        fi" C-m
fi

tmux select-window -t "$SESSION_NAME:write"
# 3. Attach (since we are now inside a terminal)
tmux attach-session -t "$SESSION_NAME"

# Configuration
#date=`date +%y%m%dT%H%M%S`
#SESSION_NAME="writing_session"
#CHAPTERS_DIR="/home/raph/Recherche/Articles/EnCours/IA-universite/Manuscrit/src/chapters/" # Change this to your actual path
#EXT="tex"                  # Change to your file extension (e.g., tex, org)

## 1. Start a new detached session
## -d prevents the script from attaching immediately
#tmux new-session -d -s "$SESSION_NAME" -n "write"

## 2. Create the other windows
#tmux new-window -t "$SESSION_NAME" -n "compile"
#tmux new-window -t "$SESSION_NAME" -n "view"

## 3. Setup the "write" window (Window 0)
## We send the command to list files, pipe to fzf, and open in vim
## We use '&&' so vim only opens if fzf doesn't exit with an error (e.g., Esc)
##tmux send-keys -t "$SESSION_NAME:write" \
    ##"selected=\$(find $CHAPTERS_DIR -name '*.$EXT' | fzf) && [ -n \"\$selected\" ] && vim \"\$selected\"" C-m
#tmux send-keys -t "$SESSION_NAME:write" \
    #"selected=\$(find $CHAPTERS_DIR -name '*.$EXT' | sed 's|^\./||' | fzf) && [ -n \"\$selected\" ] && vim \"\$selected\"" C-m

## 4. Select the first window to ensure focus is correct
#tmux select-window -t "$SESSION_NAME:write"

## 5. Attach to the session
#tmux attach-session -t "$SESSION_NAME"

##alacritty --class "noterapide" -e vim -c 'normal zz' /home/raph/Recherche/Articles/EnCours/IA-universite/Manuscrit/src/chapters/${date}.tex

