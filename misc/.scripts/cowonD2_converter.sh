#!/bin/bash
VBITRATE=1500
WIDTH=320
HEIGHT=240
FILELIST=''
SUBTITLE=""
AIDVAL=""
ASPECTVAL=""
#VOLUME=""

function usage() {
    echo "Usage: IAudioConvert [ flags ] [ file1 ] [ file2 ] [ etc. ]"
    echo
    echo "Flags:"
    echo "    -vb n"
    echo "     Set the vbitrate. Defaults to 1500."
    echo "    -td path"
    echo "    -vol 0-10"
    echo "    -aspect [aspect]"
    echo "    -aid  [audio id]"
    echo "    -sub [file].srt"
    echo "    -w n"
    echo "     Set the width. Defaults to 320."
    echo "    -h n"
    echo "     Set the height. Defaults to 240."
    echo "     Set the destination directory. Missing directories will"
    echo "     be created. Defaults to current directory."
    echo
    exit
}

# Not enough arguments
if [[ $# -lt 1 ]]; then
    echo
    echo "Not enough arguments. You must at least give one file to prepare!"
    echo
    usage
fi

index=0
flagged=0
fileflagged=0

for arg in $* ; do
    if [[ $flagged -eq 0 ]]; then
        case "${arg}" in
            -td)
                curarg=$arg
                flagged=1
            ;;

            -vb)
                curarg=$arg
                flagged=1
            ;;

            -vol)
                curarg=$arg
                flagged=1
            ;;

            -sub)
                curarg=$arg
                flagged=1
            ;;

            -aspect)
                curarg=$arg
                flagged=1
            ;;

            -aid)
                curarg=$arg
                flagged=1
            ;;

            -w)
                curarg=$arg
                flagged=1
            ;;

            -h)
                curarg=$arg
                flagged=1
            ;;

            *)
                if [[ ${arg:(-4)} == ".avi" \
		|| ${arg:(-4)} == ".mp4" \
		|| ${arg:(-4)} == ".vob" \
		|| ${arg:(-4)} == ".mov" \
		|| ${arg:(-4)} == ".wmv" \
		|| ${arg:(-4)} == ".mpg" \
		|| ${arg:(-4)} == ".AVI" \
		|| ${arg:(-4)} == ".MP4" \
		|| ${arg:(-4)} == ".VOB" \
		|| ${arg:(-4)} == ".MOV" \
		|| ${arg:(-4)} == ".WMV" \
		|| ${arg:(-4)} == ".MPG" ]]; then
                    if [[ -f $arg ]]; then
                        (( index++ ))
                        FILELIST[$index]=$arg
                    else
                        if [[ $fileflagged -eq 0 ]]; then
                            (( index++ ))
                        else
                            fileflagged=0
                        fi
                        FILELIST[$index]="${FILELIST[${index}]} ${arg}"
                        fileflagged=0
                    fi
                else
                    if [[ $fileflagged -eq 0 ]]; then
                        (( index++ ))
                        FILELIST[$index]="${arg}"
                    else
                        FILELIST[$index]="${FILELIST[${index}]} ${arg}"
                    fi
                    fileflagged=1
                fi
            ;;
        esac
    elif [[ $flagged -eq 1 ]]; then
        case "${curarg}" in
            -td)
                TARGETDIR=$arg
                flagged=0
            ;;

            -vb)
                        VBITRATE=${arg}
                flagged=0
            ;;

            -vol)
                        VOLUME=":vol=${arg}"
                flagged=0
            ;;
            -w)
                        WIDTH="${arg}"
                flagged=0
            ;;

            -h)
                        HEIGHT="${arg}"
                flagged=0
            ;;
            -sub)
                        #SUBTITLE="-sub ${arg} -subfont-text-scale 4"
                        SUBTITLE="-sub ${arg} -subfont-text-scale 3"

                flagged=0
            ;;

            -aspect)
                        ASPECTVAL="-aspect ${arg}"

                flagged=0
            ;;

            -aid)
                        AIDVAL="-aid ${arg}"

                flagged=0
            ;;

            *)
                usage
            ;;
        esac
    fi
done

clear

echo "Storing videos in ${TARGETDIR} ..."

for ((i=1;i<=$index;i++)); do
    file=${FILELIST[${i}]}
    TARGETFILENAME=`echo "${file}" | sed 's/.*\///g' | sed 's/ /_/g' | sed 's/\./#/g' | awk -F# '{print $1}'`

    if [[ ! -d $TARGETDIR ]]; then
        mkdir --parents $TARGETDIR
    fi
    TARGET=$TARGETDIR/$TARGETFILENAME

    if [[ $TARGETDIR == `pwd` ]]; then
        if [[ "${TARGETFILENAME}.avi" == "${file}" ]]; then
            echo
            echo "Source and destination file are the same!"
            echo
            exit
        fi
    fi

    echo

    MPLAYERDATA=`echo q | mplayer -identify "${file}" `
    echo "MPLAYERDATA"
    echo "$MPLAYERDATA"

    INTFPS=`echo "$MPLAYERDATA" | grep ID_VIDEO_FPS | cut -c14- | sed 's/\..*//g'`
    FPS=`echo "$MPLAYERDATA" | grep ID_VIDEO_FPS | cut -c14-  `
    echo "FPS = ${FPS}"
    echo "INTFPS = ${INTFPS}"
    if [ ${INTFPS} -ge 30 ]; then
    	FPS="-ofps 30.000"
    	echo "FPS = ${FPS}"
	else
    	FPS="" 
	fi

    INTAUDIOBR=`echo "$MPLAYERDATA" | grep ID_AUDIO_RATE | cut -c15- `


        echo "`date +%H:%M:%S` ${TARGETFILENAME}.avi "
	echo "VBITRATE = ${VBITRATE}"
	echo "INTABITRATE = ${INTAUDIOBR}"
	echo "FPS = ${FPS}"
	echo "VOLUME = ${VOLUME}"
	echo "SUBTITLE = ${SUBTITLE}"
	echo "ASPECTVAL = ${ASPECTVAL}"
	echo "AIDVAL = ${AIDVAL}"
	echo "file = ${file}"
	echo "TARGET = ${TARGET}"
	echo "WIDTH = ${WIDTH}"
	echo "HEIGHT = ${HEIGHT}"
	echo "scale=${WIDTH}:-2,expand=:${HEIGHT}:::0,crop=${WIDTH}:${HEIGHT}"
	#if [ ${INTAUDIOBR} -ge 44100 ]; then
	#	MYAUDIO="-srate 44100 -af resample=44100:1:1"
	#else
	#	MYAUDIO=""
	#
	#fi

       echo "mencoder ${file} -idx -noodml $FPS -vf scale=${WIDTH}:-2,expand=:${HEIGHT}:::0,crop=${WIDTH}:${HEIGHT} -ovc lavc -ffourcc XVID -lavcopts vcodec=mpeg4:vbitrate=${VBITRATE}:vmax_b_frames=0:vhq -sws 9 -srate 44100 -oac mp3lame -lameopts cbr:br=128:mode=0${VOLUME} ${ASPECTVAL} ${AIDVAL} ${SUBTITLE} -o ${TARGET}.avi  "

        echo "mencoder ${file} -idx -noodml $FPS -vf scale=320:-2,expand=:240:::0,crop=320:240 -ovc lavc -ffourcc XVID -lavcopts vcodec=mpeg4:vbitrate=${VBITRATE}:vmax_b_frames=0:vhq -sws 9 -srate 44100 -oac mp3lame -lameopts cbr:br=128:mode=0${VOLUME}  ${ASPECTVAL} ${AIDVAL} ${SUBTITLE} -o ${TARGET}.avi  "

       mencoder ${file} -idx -noodml $FPS -vf scale=${WIDTH}:-2,expand=:${HEIGHT}:::0,crop=${WIDTH}:${HEIGHT} -ovc lavc -ffourcc XVID -lavcopts vcodec=mpeg4:vbitrate=${VBITRATE}:vmax_b_frames=0:vhq -sws 9 -srate 44100 -oac mp3lame -lameopts cbr:br=128:mode=0${VOLUME} ${ASPECTVAL} ${AIDVAL} ${SUBTITLE} -o ${TARGET}.avi  

#       mencoder ${file} -idx -noodml $FPS -vf \
#                scale=${WIDTH}:-2,expand=:${HEIGHT}:::0,crop=${WIDTH}:${HEIGHT} 
#                -ovc lavc -ffourcc XVID -lavcopts \
#                vcodec=mpeg4:vbitrate=${VBITRATE}:vmax_b_frames=0:vhq \
#                 -sws 9 -srate 44100 -oac mp3lame -lameopts \
#                cbr:br=128:mode=0${VOLUME}  "${SUBTITLE}" -o ${TARGET}.avi  
     
    echo "`date +%H:%M:%S` Encoding finished ..."
    echo
done

