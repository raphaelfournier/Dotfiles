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

bilansdir=/home/raph/Notes/bilans/_posts/`date +%y`/`date +%m`
templatefile="/home/raph/Templates/template-bilans.mdwn"
semaine=`date "+%V"`
semaine=`echo $semaine-1 | bc` 
semaine="Bilan Semaine $semaine"
today=`date "+%Y-%m-%d"`
titre=`echo $semaine | sed "s: ::g"`
filename=${today}-${titre}.mdwn

if [ ! -d "$bilansdir" ]; then
  mkdir -p $bilansdir
fi
cd $bilansdir 
echo $semaine $filename $titre

quarterfile=`find /home/raph/Notes/bilans/ -iname '*trimestre*' | sort | tail -n1`

if [ ! -f $filename ];
then 
  cat $templatefile > $filename
  sed -i "/title/ s:$:\"$semaine\":" $filename
  sed -i "/date/ s:$:$today:" $filename
  /usr/bin/watson log | sed  "s:^\([^\t]\):* \1:" | sed "s:\t:    * :" >> $filename
fi

screen -c /home/raph/.screen/bilans.screenrc vim +19 $filename $quarterfile -O

# vim: set fdm=marker fmr=<<<,>>> fdl=0:fdc=2
