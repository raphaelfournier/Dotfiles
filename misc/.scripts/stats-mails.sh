#! /bin/bash


NEWLIP6=`ls Mail/LIP6/INBOX/new | wc -l`
NEWRFS=`ls Mail/RFS/INBOX/new | wc -l`
NEWRFNET=`ls Mail/Rfnet/INBOX/new | wc -l`
NEWCNAMNET=`ls Mail/CNAMnet/INBOX/new | wc -l`
NEWTOTAL=`echo "$NEWLIP6 + $NEWRFS + $NEWRFNET + $NEWCNAMNET" | bc`
LIP6=`ls Mail/LIP6/INBOX/cur | wc -l`
RFS=`ls Mail/RFS/INBOX/cur | wc -l`
RFNET=`ls Mail/Rfnet/INBOX/cur | wc -l`
CNAMNET=`ls Mail/CNAMnet/INBOX/cur | wc -l`

SUMLIP6=`echo "$LIP6 + $NEWLIP6" | bc`
SUMRFS=`echo "$RFS + $NEWRFS" | bc`
SUMRFNET=`echo "$RFNET + $NEWRFNET" | bc`
SUMCNAMNET=`echo "$CNAMNET + $NEWCNAMNET" | bc`
TOTAL=`echo "$SUMLIP6 + $SUMRFS + $SUMRFNET + $SUMCNAMNET" | bc`


echo "Nouveaux mails :"
echo "  LIP6    $NEWLIP6"
echo "  RFS     $NEWRFS"
echo "  Rfnet   $NEWRFNET"
echo "  CnamNet $NEWCNAMNET"
echo "--> TOTAL $NEWTOTAL"
echo
echo "Total Inbox :"
echo "  LIP6    $SUMLIP6"
echo "  RFS     $SUMRFS"
echo "  Rfnet   $SUMRFNET"
echo "  CnamNet $SUMCNAMNET"
echo "--> TOTAL $TOTAL"
echo
echo "Stats :"
echo "  LIP6    $NEWLIP6/$SUMLIP6"
echo "  RFS     $NEWRFS/$SUMRFS"
echo "  Rfnet   $NEWRFNET/$SUMRFNET"
echo "  CnamNet $NEWCNAMNET/$SUMCNAMNET"


