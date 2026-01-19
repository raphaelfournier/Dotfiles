#! /bin/bash
# RFS 29/12/2023

randomfolder="/home/raph/Images/Wallpapers/Random"
notrandomfolder="/home/raph/Images/Wallpapers/PasRandom"

for file in `ls ${randomfolder}`
do
  FILE=$notrandomfolder/$file
  #echo $FILE
  if test -f "$notrandomfolder/$file"; then
    echo "$FILE exists."
fi

done
