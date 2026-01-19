#!/bin/bash

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# http://unix.stackexchange.com/questions/89016/notifications-and-notification-daemon-not-working-on-window-manager
