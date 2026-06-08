#! /bin/bash

#pdfcrop --margins '5 15 5 15' $1 out.pdf && pdfjam --nup 2x1 --landscape out.pdf --outfile output_2up.pdf && zathura output_2up.pdf
pdfcrop --margins '5 5 5 5' $1 out.pdf && pdfjam --nup 2x1 --landscape out.pdf --outfile "$(basename "$1" .pdf)-2upCrop.pdf" 
#&& zathura "$(basename "$1" .pdf)-2upCrop.pdf"
echo "Finshed cropping and 2up. run zathura $(basename "$1" .pdf)-2upCrop.pdf"
