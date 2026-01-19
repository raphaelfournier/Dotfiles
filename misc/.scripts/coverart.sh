#!/bin/bash

DEFAULT_COVER="/usr/share/pixmaps/sonatacd_large.png"

MUSICDIR=`cat /home/raph/.mpd/mpd.conf | grep -v "#" | grep music_directory | sed "s:\"::g"`
MUSICDIR=${MUSICDIR:16}
MUSICDIR=${MUSICDIR%/$}

MFILE=`mpc current -f %file%`
MFILE=${MFILE%/*}
MFILE=${MFILE%/$}

FULLDIR="$MUSICDIR/$MFILE"

COVERS=`ls "$FULLDIR" | grep "\.jpeg\|\.jpg\|\.png\|\.gif"`

if [ -z "$COVERS" ]; then
    COVERS="$DEFAULT_COVER"
else
    TRYCOVERS=`echo "$COVERS" | grep "cover\|front" | head -n 1`

    if [ -z "$TRYCOVERS" ]; then
        TRYCOVERS=`echo "$COVERS" | head -n 1`
        if [ -z "$TRYCOVERS" ]; then
            TRYCOVERS="$DEFAULT_COVER"
        else
            TRYCOVERS="$FULLDIR/$TRYCOVERS"
        fi
    else
        TRYCOVERS="$FULLDIR/$TRYCOVERS"
    fi

    COVERS="$TRYCOVERS"
fi

echo -n "$COVERS"
