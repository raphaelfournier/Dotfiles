#! /bin/bash

FILE="/home/raph/.fzf-marks"

echo "chemins qui n'existent plus"
for foo in `cat $FILE | awk '{print $3}'`
do 
  [ ! -d $foo ] && echo $foo
done 
