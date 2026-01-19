#! /bin/bash
param=`cvt 1024 768 | grep "Mode" | cut -d " " -f 3-14`
xrandr --newmode foo $param
xrandr --addmode DP1 foo
xrandr --output DP1 --mode foo --output eDP1 --mode 1366x768 --left-of DP1
xmodmap /home/raph/.Xmodmapcnam
