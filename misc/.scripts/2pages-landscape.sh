#! /bin/bash
# RFS 04/01/2024

original=`basename $1 .pdf`
uncropped=$original"_uncropped.pdf"
output=`basename $1 .pdf`"-2in1.pdf"
pdf-crop-margins -v -m2 -p 1 -a -6 -mo $1
pdfnup $1 --no-landscape --rotateoversize=false --scale 0.96 --delta "1cm 2cm" -o $output
mv $uncropped $original.pdf
echo -e "\nC'est bon, ton fichier est prêt :\nzathura $output"

