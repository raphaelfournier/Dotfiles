#! /bin/bash
# 16/12/2023

cat .mutt/aliases | grep -v "#" | cut -d " " -f 3- | rofi -dmenu -i | grep -o "<.*>" | sed 's/^.//;s/.$//' | xclip -selection clipboard
