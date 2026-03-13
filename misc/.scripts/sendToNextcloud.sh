#! /bin/bash

if [ $# -ne 1 ]
then
  echo "ERROR: Wrong number of arguments"
  echo "cp -rv \$1 /home/raph/Cloud/SambaIpadLinux/"
  echo "1 = file"
  exit 1
fi

cp -rv "$1" /home/raph/Cloud/SambaIpadLinux/
echo "copie réalisée !"
