#! /bin/bash

CONFIG=$1
if [[ $1 == "vanilla" ]]; then
  echo "going back to vanilla config"
  rm /home/raph/.config/awesome
  /usr/bin/ln -s ~/Dotfiles/awesome/.config/awesome-vanilla ~/.config/awesome
elif [[ $1 == "modular" ]]; then
  echo "going to modular config"
  rm /home/raph/.config/awesome
  #/usr/bin/ln -s ~/Code/Configurations/AwesomeWM/MesConfigs/modular ~/.config/awesome
  /usr/bin/ln -s /home/raph/Dotfiles/awesome/.config/awesome-awesome-rc ~/.config/awesome
  echo "cd /home/raph/Dotfiles/awesome/.config/awesome-awesome-rc"
  #echo "vim -O todolist rc.vanilla.24-01-13.lua"

else
  echo "trying config $1"
  rm /home/raph/.config/awesome
  CONFIGPATH="/home/raph/Code/Configurations/AwesomeWM/Examples/${CONFIG}"
  /usr/bin/ln -s $CONFIGPATH ~/.config/awesome
fi
