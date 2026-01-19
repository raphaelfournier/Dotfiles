#! /usr/bin/env bash
# File: tomatoe.sh
# What the..?: A simple timer to apply The Pomodoro Technique.
# Who the..?: ksaver (at identi.ca).
# Why? : In the Hope of this little script can be useful...
# When?: July 2010.
# Requieres: bash, play, zenity (nix like OS, of course).
# More Info: http://www.pomodorotechnique.com
# License: Public Domain.
# Not any warranty at all.
#---------------------------------------------------------------

scriptname=$(basename $0 .sh)
scriptvers='0.6'

## --- Set preferences ---
minute=60 # Secs in one min. 60 (habitually).
m_resting=5 # Resting time. Default 05 minutes.
m_working=25 # Working time. Default 25 minutes.
s_resting=$(($m_resting*$minute)) # seconds to resting.
s_working=$(($m_working*$minute)) # seconds to working.
audio_warning="/home/$USER/Audio/attention.wav" # some cute audio warning.
## -----------------------

function starting_dialog()
 {
zen_dialog --title "$scriptname - $scriptvers" --question \
--text="Starting Tomatoe Timer:\
 \n$m_working Mins Working/$m_resting Mins Resting."
return $?
}

function tomatoe_timer()
 {
TASK=$1
LIMIT=$2
COUNT=0
while [ $COUNT -lt $LIMIT ]
do
echo $(($COUNT*100/$LIMIT)) # % percentage %
let COUNT=$COUNT+1
sleep 1
done | zen_dialog --title="Cycles: $count_cycle" --progress --auto-close \
--text="Time to $TASK ($(($LIMIT/$minute)) $COUNT)...\t"
return $?
}

function zen_alert()
 {
#play "$audio_warning" & # Decomment if you want a sound warning.
zen_dialog --title="Cycles: $count_cycle" --question \
--text="Time to $1 has finished!\nShall I Continue?"
return $?
}

function zen_dialog()
 {
/usr/bin/env zenity "$@"
}

function __main__()
 {
count_cycle=1
starting_dialog || exit
while true
do
tomatoe_timer "work" $s_working
zen_alert "work" || exit
tomatoe_timer "have a break" $s_resting
zen_alert "have a break" || exit
let count_cycle=$count_cycle+1
done
}

## Run script...
__main__
