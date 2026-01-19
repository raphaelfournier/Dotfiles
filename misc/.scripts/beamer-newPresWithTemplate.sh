#! /bin/bash

if [ "$#" -ne 1 ]; then
  echo "ERREUR : il faut passer le nom du cours en paramètres"
  exit 1
fi

cp -rv ~/Enseignement/template-slides/ $1
