#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Mail : adi1090x@gmail.com
## Github : @adi1090x
## Reddit : @adi1090x

rofi_command="rofi -theme themes/menu/volume.rasi"

## Get Volume
#VOLUME=$(amixer get Master | tail -n 1 | awk -F ' ' '{print $5}' | tr -d '[]%')
MUTE=$(amixer get Master | tail -n 1 | awk -F ' ' '{print $6}' | tr -d '[]%')

active=""
urgent=""

if [[ $MUTE == *"off"* ]]; then
    active="-a 2"
else
    urgent="-u 0"
fi

if [[ $MUTE == *"on"* ]]; then
    VOLUME="$(amixer get Master | tail -n 1 | awk -F ' ' '{print $5}' | tr -d '[]%')%"
else
    VOLUME="Muted"
fi

## Icons
ICON_UP="ﱛ"
ICON_DOWN="ﱜ"
ICON_MUTED="ﱝ"
#ICON_PMGR=""
ICON_PMGR=""

options="$ICON_PMGR\n$ICON_UP\n$ICON_MUTED\n$ICON_DOWN"

## Main
chosen="$(echo -e "$options" | $rofi_command -p "$VOLUME" -dmenu $active $urgent -selected-row 2)"
case $chosen in
    $ICON_UP)
        amixer -Mq set Master,0 5%+ unmute && notify-send -u low -t 1500 "Volume Up $ICON_UP"
        ;;
    $ICON_DOWN)
        amixer -Mq set Master,0 5%- unmute && notify-send -u low -t 1500 "Volume Down $ICON_DOWN"
        ;;
    $ICON_MUTED)
        amixer -q set Master toggle
        ;;
    $ICON_PMGR)
        pavucontrol
        ;;
esac

