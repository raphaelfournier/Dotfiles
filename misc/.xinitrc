xrdb -merge ~/.Xresources
#compton -bCG & # transparence
# urxvt daemon
#urxvtd -q -o -f
#xscreensaver -no-splash &
/home/raph/.scripts/locker.sh &
#udisksvm --auto &
udiskie -san &
touchegg &
#eval $(gpg-agent --daemon) &
#xcompmgr &
#skype &
#wicd-client &
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
mpDris2 &
pasystray &
nextcloud & 
#stretchly &
#ticktick &
#wal -R & 
#rambox &
#ferdi &
# xpad &
#dunst &
#cbatticon &
#pidgin &
#sudo netcfg-menu &
#dropbox &
#/usr/bin/dropbox &
#udiskie --tray &
[ ! -s ~/.config/mpd/pid ] && mpd &
musnify-mpd &
setxkbmap -option caps:escape &
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap &
DEFAULT_SESSION=awesome
#DEFAULT_SESSION=gnome-session
#DEFAULT_SESSION=wmii
#DEFAULT_SESSION=i3
exec $DEFAULT_SESSION
#exec gnome-session
