#! /bin/bash
#param=`cvt 1024 768 | grep "Mode" | cut -d " " -f 3-14`
#xrandr --newmode videoproj $param
#xrandr --addmode VGA1 videoproj 
xrandr --output LVDS1 --mode 1024x768
xrandr --output VGA1 --mode 1024x768 --same-as LVDS1
#xrandr --output VGA1 --mode videoproj --same-as LVDS1
