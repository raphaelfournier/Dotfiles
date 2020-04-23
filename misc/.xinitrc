xrdb -merge ~/.Xresources
#compton -bCG & # transparence
# urxvt daemon
urxvtd -q -o -f
#xscreensaver -no-splash &
#udisksvm --auto &
udiskie -san &
#
#eval $(gpg-agent --daemon) &
#xcompmgr &
#skype &
#wicd-client &
/home/raph/scripts/setDbusSessionBusAddress.sh &
nm-applet --sm-disable &
arandr-indicator &
#wal -R & 
#rambox &
# xpad &
#dunst &
#cbatticon &
#pidgin &
#sudo netcfg-menu &
#dropbox &
#udiskie --tray &
setxkbmap -option caps:escape
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
DEFAULT_SESSION=awesome
#DEFAULT_SESSION=gnome-session
#DEFAULT_SESSION=wmii
#DEFAULT_SESSION=i3
exec $DEFAULT_SESSION
#exec gnome-session
