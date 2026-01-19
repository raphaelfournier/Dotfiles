#! /bin/bash
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for i in "$@"
do
  echo "pushing $i to /sdcard1/Podcasts/"
  adb push $i /external_sd/Podcasts/
done
IFS=$SAVEIFS
