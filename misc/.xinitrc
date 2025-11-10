xrdb -merge ~/.Xresources
#compton -bCG & # transparence
# urxvt daemon
#urxvtd -q -o -f
#xscreensaver -no-splash &
/home/raph/.scripts/locker.sh &
udiskie -san &
touchegg &
#eval $(gpg-agent --daemon) &
#dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY
blueman-applet &
# blueberry-tray &
#/home/raph/.scripts/setDbusSessionBusAddress.sh &
nm-applet --sm-disable &
arandr-indicator &
#vgrive &
greenclip daemon &
tmux new -d &
indicator-sound-switcher &
redshift &
x-on-resize -a &
#picom &
pasystray &
#nextcloud & 
#stretchly &
#ferdi &
# xpad &
#cbatticon &
#sudo netcfg-menu &
#/usr/bin/dropbox &
#udiskie --tray &
[ ! -s ~/.config/mpd/pid ] && mpd &
musnify-mpd &
mpDris2 &
setxkbmap -option caps:escape &
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap &
DEFAULT_SESSION=awesome
#DEFAULT_SESSION=gnome-session
#DEFAULT_SESSION=i3
exec $DEFAULT_SESSION
