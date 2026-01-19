#! /bin/bash

# <<< functions
concatenate_args()
{
    string=""
    delimiter=$1
    arguments="${@:2}"
    for a in $arguments # Loop over arguments
    do
        if [[ "${a:0:1}" != "-" ]] # Ignore flags (first character is -)
        then
            if [[ "$string" != "" ]]
            then
                string+=$delimiter # Delimeter
            fi
            string+="$a"
        fi
    done
    echo "$string"
}


function usage() {
    echo "Usage: ./reunion.sh <nom de la reunion>"
    echo
    exit
}

function gotodirMeetingsDir() {
  echo $meetingsdir 
}
#>>>

meetingsdir=/home/raph/Notes/meetings/_posts/`date +%y`/
templatefile=/home/raph/Templates/template-reunion.mdwn
date=`date "+%Y-%m-%d"`
args="$(concatenate_args "-" "$@")"
title=$@
nom=`echo $args | sed "s: :-:g"`
titre=${date}-${nom}.mdwn

# Not enough arguments
if [[ $# -lt 1 ]]; then
    usage
fi

if [ ! -d "$meetingsdir" ]; then
  mkdir $meetingsdir
fi
cd $meetingsdir 
cat $templatefile | sed -e "s:<++>foobar:${title}:g" >> $titre
sed -i "/title/ s:$:$title:" $titre
sed -i "/date/ s:$:$date:" $titre
tmuxinator reunion file=$titre
echo "$meetingsdir/$titre"

# vim: set fdm=marker fmr=<<<,>>> fdl=0:fdc=2
