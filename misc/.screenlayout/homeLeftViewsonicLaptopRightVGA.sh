#!/bin/sh

if [ "$(xrandr| grep -c "DP1 conn")" -ge 1 ]; then
  xrandr --output eDP1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP2 --off --output DP1-1 --off --output DP1-2 --off --output DP1-3 --off --output DP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI1 --off --output HDMI2 --off --output VIRTUAL1 --off
else
  xrandr --output eDP1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP1 --off --output DP1-1 --off --output DP1-2 --off --output DP1-3 --off --output DP2 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI1 --off --output HDMI2 --off --output VIRTUAL1 --off
fi
