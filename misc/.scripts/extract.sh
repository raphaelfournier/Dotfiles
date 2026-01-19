#! /bin/sh
ARCHIVE=$1
DEST="echo $2 | sed s:\.avi$:.srt:"
echo $DEST
#unzip -cbq $1 | ssh raph@rfournier.homelinux.org "cat > /mnt/Data/Downloaded/$DEST"
