#!/bin/bash

#export DISPLAY=127.0.0.1:0.0
#export XAUTHORITY=/home/matrix/.Xauthority
#echo "testing cron" >/tmp/crontest
#sudo -u matrix /usr/bin/notify-send "hello"
#echo "now tested notify-send" >>/tmp/crontest

if [ -r "$HOME/.dbus/Xdbus" ]; then
  . "$HOME/.dbus/Xdbus"
fi

date=`date +"%H:%M"`
/usr/bin/notify-send -i /home/raph/.scripts/utils/clock-24.png -u low "$date"
