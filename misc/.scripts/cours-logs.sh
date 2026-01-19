#! /bin/bash

FILE=/home/raph/Enseignement/Logs/cours-`date +%Y`.log.md

echo -e "\n##" `date +%c`"\n\n" >> ${FILE}

vim +star ${FILE} +
