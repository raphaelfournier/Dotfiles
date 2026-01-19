#! /bin/bash
#param=`cvt 1920 1200 | grep "Mode" | cut -d " " -f 3-14`
#xrandr --newmode ecran $param
#xrandr --addmode VGA1 ecran
xrandr --output VGA1 --mode 1920x1080 --output LVDS1 --off
#xrandr --output LVDS1 --mode 1280x800
#xrandr --output VGA1 --mode 1920x1080 --right-of LVDS1
