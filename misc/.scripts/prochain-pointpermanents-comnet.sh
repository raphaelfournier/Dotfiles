#! /bin/bash

POINT=`ls /home/raph/Recherche/LIP6/DirectionEquipeCN/Personnes/PointsPermanents/2* | tail -1` 

alacritty --class "noterapide" -e vim ${POINT} + -c 'normal zz' -c 'MarkdownPreview'

