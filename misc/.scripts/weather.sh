#!/bin/sh
choice=$(echo "" | dmenu -p 'Please write city to check weather: ')
link="wttr.in/$choice"
kitty --hold -- bash -c "curl $link; read -p 'Press Enter to exit'"
