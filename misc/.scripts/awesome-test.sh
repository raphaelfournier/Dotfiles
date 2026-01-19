#!/bin/bash
# script xepyhr-awesome
# author: dante4d <dante4d@gmail.com>
Xephyr -ac -br -noreset -screen 1024x768 :1 &
sleep 1
#DISPLAY=:1.0 awesome -c ~/.config/awesome/awesome.lua.new
#/etc/xdg/awesome/
DISPLAY=:1.0 awesome -c ~/.config/awesome/rc.lua

