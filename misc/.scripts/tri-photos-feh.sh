#!/bin/bash
mkdir -p 1-print/ 2-goodphotos/ 3-incertain/ 4-mesphotos/ 5-trash/ 6-autres/ 7-a-utiliser/
feh -F \
  -G \
  --draw-exif -d --draw-tinted -Y \
  --action1 "~/.scripts/feh-move.sh 1-print %f" \
  --action2 "~/.scripts/feh-move.sh 2-goodphotos %f" \
  --action3 "~/.scripts/feh-move.sh 3-incertain %f" \
  --action4 "~/.scripts/feh-move.sh 4-mesphotos %f" \
  --action5 "~/.scripts/feh-move.sh 5-trash %f" \
  --action6 "~/.scripts/feh-move.sh 6-autres %f" \
  --action7 "~/.scripts/feh-move.sh 7-a-utiliser %f" \
  "$@"

