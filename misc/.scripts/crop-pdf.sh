#! /bin/bash

pdfcrop --margins '5 15 5 15' $1 out.pdf && pdfjam --nup 2x1 --landscape out.pdf --outfile output_2up.pdf && zathura output_2up.pdf
#echo "Finshed cropping and 2up. run zathura output_2up.pdf"
