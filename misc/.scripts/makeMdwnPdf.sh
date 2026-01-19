#! /bin/bash

function usage() {
    echo "Usage: ./makeMdwnPdf.sh <nom de fichier.mdwn>"
    echo
    exit
}

if [[ $# -lt 1 ]]; then
    usage
fi

templatedir="/home/raph/Templates"
textemp=${templatedir}/pandoc-pdf.tex
filename=`basename $1 .mdwn`
mainfont="Georgia"
sansfont="Arial"
#monofont="Monospace"
#monofont='Sans'
fontsize="12pt"
toc="--toc "

#echo -N --template=$textemp --variable mainfont=$mainfont --variable sansfont=$sansfont --variable monofont=$monofont --variable fontsize=$fontsize --variable lang=french --variable geometry="margin=1in" $1 --latex-engine=xelatex $toc -o ${filename}.pdf

pandoc -N --template=$textemp --variable mainfont=$mainfont --variable sansfont=$sansfont --variable monofont=$monofont --variable fontsize=$fontsize --variable lang=french --variable geometry="margin=1in" $1 --latex-engine=xelatex $toc -o ${filename}.pdf

# vim: set fdm=marker fmr=<<<,>>> fdl=0:fdc=2
