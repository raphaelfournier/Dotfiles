#! /bin/bash

notify-send "suspending..."
wmctrl -x -c "termportal" 
sudo systemctl suspend
