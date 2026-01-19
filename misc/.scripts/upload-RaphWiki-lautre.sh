HOST='ftp.lautre.net'
USER='rfs'
PASSWD='Passer_8'
LOCALPATH='/home/raph/public_html/RaphWiki'
#FILE=*
DIR='wiki/'

ftp -n $HOST <<EOF
quote USER $USER
quote PASS $PASSWD
cd $DIR
lcd $LOCALPATH
mput *
quit
exit;
EOF
