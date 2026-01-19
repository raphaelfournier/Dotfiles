# /bin/bash
date=`date +%y%m%d`
path="/home/raph/Log"
file=$path/${date}.jrnl
if [ ! -f $file ]
then
  touch $file
  echo "Journal du `date +\"%d %m %Y\"`" >> $file
  cat ~/.templates/journal >> $file
fi
vim $file
