#! /bin/bash

FILE="/home/raph/.fzf-marks"

for foo in `cat $FILE | awk '{print $3}'`
do 
  [ ! -d $foo ] && echo $foo
done 
