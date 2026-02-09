#!/bin/bash
# Save this as ~/.local/bin/mutt-open and make it executable

FILE=$1
# List your preferred programs here
OPTIONS="zathura\nevince\nokular\nfirefox\nchromium"

# Use rofi to get the choice
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Open with:")

NEWFILE="/tmp/mutt-`date +%s`.pdf"
mv $FILE $NEWFILE

# If a choice was made, run it in the background
if [ -n "$CHOICE" ]; then
    $CHOICE "$NEWFILE" &
    # Optional: wait a sec then delete the file, 
    # but /tmp usually cleans itself on reboot anyway
    #(sleep 5 && rm -f "$FILE") &
fi
