#!/bin/bash
#Arguments: URL, Time stamp -5 seconds, length of clip, video file name

function usage() {
  echo "Usage: ./clip-youtube.sh <URL> <Timestamp -5 secondes> <length (in seconds)> <output name>"
    echo
    exit
}

if [[ $# -lt 1 ]]; then
    usage
fi

readarray -t urls <<< "$(yt-dlp --youtube-skip-dash-manifest -g "$1")"
ffmpeg -ss $2 -i "${urls[0]}" -ss $2 -i "${urls[1]}" -ss 5 -map 0:v -map 1:a -c:v libx264 -c:a aac -t $3 $4

