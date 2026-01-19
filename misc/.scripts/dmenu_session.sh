#!/bin/bash
#
# a simple dmenu session script 
#
###

DMENU='dmenu -i -b -f -nb #000000 -nf #999999 -sb #000000 -sf #31658C'
choice=$(echo -e "logout\nshutdown\nreboot\nsuspend" | $DMENU)

case "$choice" in
  logout) echo "" exit & ;;
  shutdown) sudo halt & ;;
  reboot) sudo reboot & ;;
  suspend) sudo pm-suspend & ;;
#  hibernate) sudo pm-hibernate & ;;
esac
