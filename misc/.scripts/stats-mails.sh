#! /bin/bash

echo "Nouveaux mails :"

LIP6=`ls Mail/LIP6/INBOX/new | wc -l`
RFS=`ls Mail/RFS/INBOX/new | wc -l`
RFNET=`ls Mail/Rfnet/INBOX/new | wc -l`
TOTAL=`echo "$LIP6 + $RFS + $RFNET" | bc`

echo " LIP6  $LIP6"
echo " RFS   $RFS"
echo " Rfnet $RFNET"
echo
echo " TOTAL $TOTAL"
