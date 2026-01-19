#! /bin/bash
# RFS 30/12/2023
#
randomfolder="/home/raph/Images/Wallpapers/Random"
notrandomfolder="/home/raph/Images/Wallpapers/PasRandom"

nitrogenconf="/home/raph/.config/nitrogen/bg-saved.cfg"

filename=`basename $(cat $nitrogenconf | grep file | sed "s:^.*=::")`

mv -v $randomfolder/$filename $notrandomfolder/$filename

