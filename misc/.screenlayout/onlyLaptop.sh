#!/bin/sh
#xrandr --output VIRTUAL1 --off --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP1 --off --output HDMI2 --off --output HDMI1 --off --output DP1-2 --off --output DP1-1 --off --output DP2 --off
keep="eDP1"
xrandr --output $keep --auto \
  $(xrandr | awk '/ connected/{print $1}' | grep -v '^HDMI-1$' | xargs -I{} echo --output {} --off)
