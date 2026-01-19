#!/usr/bin/env bash

#menu=$(mpc playlist -f '%position%\t %artist%\t%title%\t%date% %album%' | column -t -s $'\t' -o $' ' | rofi -dmenu -i -p '> ')
menu=$(mpc playlist -f '%position%\t %artist%\t%title%\t %album%' | awk -F "\t" 'BEGIN { OFS=FS }; { $2=substr($2, 1, 30); $3=substr($3, 1, 30); $4=substr($4, 1, 30);print }' | column -t -s $'\t' -o $' ' | rofi -dmenu -i -p '> ')
val=$?

id="$(echo "${menu}" | awk -F ' ' '{ print $1 }' | sed "s: ::g")" 

if [[ $val -eq 1 ]]; then
    exit
else
    mpc play "${id}"
fi
