#! /bin/bash

if [ $# -ne 1 ]
then
  echo "ERROR: Wrong number of arguments"
  echo "scp \$1 raph@lepoulpe:/srv/www/stockage/"
  echo "1 = file"
  exit 1
fi

scp $1 raph@lepoulpe:/srv/www/stockage/
echo "view at http://stockage.fournier-sniehotta.fr/$1"
echo "http://stockage.fournier-sniehotta.fr/$1" | qrencode -t ansiutf8 
