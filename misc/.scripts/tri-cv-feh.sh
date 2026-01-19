#!/bin/bash
mkdir -p 1-oui/ 2-incertain/ 3-non/
feh -F \
  -G \
  --draw-exif -d --draw-tinted -Y \
  --action1 "~/.scripts/feh-move.sh 1-oui %f" \
  --action2 "~/.scripts/feh-move.sh 2-incertain %f" \
  --action3 "~/.scripts/feh-move.sh 3-non %f" \
  "$@"

