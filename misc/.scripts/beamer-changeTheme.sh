#! /bin/bash

#if [ "$#" -ne 1 ]; then
  #echo "ERREUR : il faut passer le nom du cours en paramètres"
  #exit 1
#fi

ANNEE="2526"

rm -rf themes/
cp -rv ~/Enseignement/SlidesBeamer/${ANNEE}/themes .
