#!/bin/bash

dest="$1"
file="$2"

[ -z "$dest" ] && exit 1
[ -z "$file" ] && exit 1

# Absolute path of destination folder
dir="$(dirname "$file")/$dest"
mv -vn "$file" "$dir/"
notify-send -t 1200 "move" "$file $dir/$file"
