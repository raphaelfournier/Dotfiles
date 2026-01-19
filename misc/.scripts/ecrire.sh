#! /bin/bash

date=`date +%y%m%dT%H%M%S`
alacritty --class "noterapide" -e vim -c 'normal zz' -c 'MarkdownPreview' /home/raph/Publications/Livre-Pandoc/ideas/${date}-idee.md +
