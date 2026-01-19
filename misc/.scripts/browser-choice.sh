#!/bin/bash
# Choice disabled: all links go to chromium, except magnet links

title="Ouvrir l'URL avec"
options=("firefox" "chromium" "luakit" "opera" "mutt" "dialogue")
u=$1

echo $u | grep -q "magnet"
choice=$?
#notify-send "choice" $choice

if [ $choice -ne 0 ]; then
  echo $u | grep -q "^mailto"
  mailto=$?
  if [ $mailto -ne 0 ]; then
    opt="firefox"
    notify-send "opening in $opt" $u
  else
    notify-send "lien mailto" $mailto
    echo $u > /tmp/foo
    medit /tmp/foo
  fi
else 
  opt="firefox"
  notify-send "opening in $opt" $u
  #opt=$(zenity --title="$title" --text="" --width=300 --height=280 --list --column="Navigateur" "${options[@]}")
  #if [ ! -z $opt ]; then
    #notify-send "opening in ${opt}" $u
  #fi
fi

nohup $opt $u &
