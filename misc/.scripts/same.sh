#! /bin/bash
param=`cvt 1920 1200 | grep "Mode" | cut -d " " -f 3-14`
xrandr --newmode ecran $param
xrandr --addmode VGA1 ecran
xrandr --output LVDS1 --mode 1280x800
xrandr --output VGA1 --mode ecran --same-as LVDS1
