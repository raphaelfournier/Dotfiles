#! /bin/bash

bilansdir=/home/raph/Notes/bilans/_posts/`date +%y`/
lastbilan=`find $bilansdir -type f -iname "*Semaine*" | sort | tail -n1`

vim -O diary $lastbilan -c ":VimwikiMakeDiaryNote" 
