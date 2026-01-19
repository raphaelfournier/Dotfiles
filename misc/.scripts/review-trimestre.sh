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
templatefile="/home/raph/Templates/template-bilans-trimestre.mdwn"
month=`date "+%-m"`
quarter="Q$((($month-1)/3 + 1))"

titre="Objectifs Trimestre $quarter"
today=`date "+%Y-%m-%d"`
filename=${today}-`echo $titre | sed "s: ::g"`.mdwn

if [ ! -d "$bilansdir" ]; then
  mkdir -p $bilansdir
fi
cd $bilansdir 
echo $semaine $filename $titre

yeargoals=`find /home/raph/Notes/bilans/ -iname '*objectifs*' | sort | tail -n1`

if [ ! -f $filename ];
then 
  cat $templatefile > $filename
  sed -i "/title/ s:$:\"$titre\":" $filename
  sed -i "/date/ s:$:$today:" $filename
fi

screen -c /home/raph/.screen/bilans.screenrc vim +12 $filename $yeargoals -O

# vim: set fdm=marker fmr=<<<,>>> fdl=0:fdc=2
