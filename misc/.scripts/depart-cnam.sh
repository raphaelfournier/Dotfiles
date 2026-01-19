#! /bin/bash
autorandr -l laptop-only
xrandr --output eDP1 --mode 1920x1080 --output DP1-2 --off --output DP1-1 --off --output DP2 --off --output DP1 --off
watson stop
mpc stop
amixer -D pulse sset Master mute
sudo umount /dev/sdc1 /dev/sdc3 /dev/sdc4 /dev/sdc5
