#! /bin/bash
#xrandr --output DP1 --mode 1360x768 --right-of eDP1
param=`cvt 1360 768 | grep "Mode" | cut -d " " -f 3-14`
xrandr --newmode tele $param
xrandr --addmode DP1 tele
xrandr --output DP1 --mode tele --output eDP1 --mode 1366x768 --left-of DP1
