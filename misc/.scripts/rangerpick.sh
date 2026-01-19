#! /bin/bash

tmpfile=/home/raph/.mutt/rangerpick
touch $tmpfile

if \[ -z "$1" \]; then
   ranger --choosefiles $tmpfile && echo "$(awk 'BEGIN {printf "%s", "push "} {printf "%s", "<attach-file>"$0"<enter>"}'  $tmpfile)" > $tmpfile
elif \[ $1 == "clean" \]; then
  rm $tmpfile
fi
