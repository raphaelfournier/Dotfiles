#! /bin/bash

reverse=0

Help()
{
  # Display Help
  echo "bak.sh backups up one file with a .bak extension, to avoid mistakes."
  echo
  echo "Syntax: bak.sh [-hu] file"
  echo
  echo "Beware that only one filename should be used at a time."
  echo
  echo "options:"
  echo "h     Print this Help."
  echo "u     undo: mv file.bak file"
  echo
}

Main(){
  echo "mv -i $1 $1.bak"
  mv -i $1 $1.bak
}

Undo(){
  echo "mv -i $1.bak $1"
  mv -i $1.bak $1
}

while getopts "hu" option; do
   case $option in
      h) # display Help
         Help
         shift
         exit;;
      u) reverse=1
        shift
        ;;
   esac
done

if [ $# -ge 2 ] 
then
  Help
else
  if [ $reverse == 0 ]
  then 
    Main $1
  else
    Undo $1
  fi
fi
