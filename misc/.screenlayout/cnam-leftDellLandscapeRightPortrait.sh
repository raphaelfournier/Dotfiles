#!/bin/sh

if [ "$(xrandr| grep -c "DP2 dis")" -ge 1 ]; then
  xrandr --output eDP1 --off --output DP2 --off --output DP1-1 --mode 1920x1080 --pos 2560x0 --rotate right --output DP1-8 --primary --auto --pos 0x0 --rotate normal --output DP3 --off --output DP4 --off --output HDMI1 --off --output HDMI2 --off --output HDMI3 --off --output HDMI4 --off --output HDMI5 --off --output VIRTUAL1 --off
else
  xrandr --output eDP1 --off --output DP2 --off --output DP2-1 --mode 1920x1080 --pos 2560x0 --rotate right --output DP2-8 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DP3 --off --output DP4 --off --output HDMI1 --off --output HDMI2 --off --output HDMI3 --off --output HDMI4 --off --output HDMI5 --off --output VIRTUAL1 --off
fi

nitrogen --restore

