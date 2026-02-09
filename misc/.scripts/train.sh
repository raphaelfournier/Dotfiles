#! /bin/bash
FILE="/home/raph/.trainsncf"
TRAIN=$(cat $FILE)

# on sort du train, on y était
if [[ $TRAIN == "train" ]] 
then
  MESSAGE="on sort du train"
  echo "pastrain" > ~/.trainsncf
  wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
  rfkill unblock wlan
else
  MESSAGE="on arrive dans le train, on coupe le wifi"
  echo "train" > ~/.trainsncf
  LOGFILE=`date +%y%m%dT%H%M%S`.log
  rsync -avz Mail/CNAM Mail/CNAMnet Mail/LIP6 Mail/Rfnet Mail/RFS /data/backupMails >> /data/backupMails/logs/$LOGFILE && notify-send "mails copiés"
  mpc stop
  wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
  rfkill block wlan
fi
notify-send "$MESSAGE"
