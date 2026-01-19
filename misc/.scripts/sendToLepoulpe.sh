#! /bin/bash

if [ $# -ne 2 ]
then
  echo "ERROR: Wrong number of arguments"
  echo "scp \$1 raph@lepoulpe:/srv/www/raphael/temp/\$2.html"
  echo "1 = file.html"
  echo "2 = outfilename.html"
  exit 1
fi

scp $1 raph@lepoulpe:/srv/www/raphael/temp/$2.html
echo "view at http://raphael.fournier-sniehotta.fr/temp/$2.html"
