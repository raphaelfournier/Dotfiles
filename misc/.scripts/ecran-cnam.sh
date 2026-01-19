#! /bin/bash
param=`cvt 1920 1080 | grep "Mode" | cut -d " " -f 3-14`
xrandr --newmode ecran $param
xrandr --addmode DP1 ecran
xrandr --output DP1 --mode ecran --output eDP1 --mode 1366x768 --left-of DP1
xmodmap /home/raph/.Xmodmapcnam
