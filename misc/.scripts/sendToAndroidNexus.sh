#! /bin/bash

if [ $# -ne 1 ]
then
  echo "ERROR: Wrong number of arguments"
  echo "cp file /home/raph/Cloud/TabletteNexusAndroid"
  exit 1
fi

cp -v $1 /home/raph/Cloud/TabletteNexusAndroid
