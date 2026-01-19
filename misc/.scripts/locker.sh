#!/bin/sh

#xautolock -detectsleep -time 3 -resetsaver -locker "~/.scripts/i3lock-image.sh" -notify 12 -notifier "notify-send -u critical -t 11000 -- 'LOCKING screen in 12 seconds'"
xautolock -detectsleep -time 8 -nowlocker "~/.scripts/i3lock-image.sh" -locker "~/.scripts/i3lock-image-mpd.sh" -notify 12 -notifier "notify-send -u critical -t 10000 -- 'Verrouillage dans 10 secondes'"
