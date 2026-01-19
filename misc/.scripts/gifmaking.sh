#!/bin/sh
# http://blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html#usage
# ./gifmaking.sh input.mp4 anim.gif
# 
# alternative ffmpeg -ss 00:00:41 -to 00:01:26 -i fallet.mp4 -vf "fps=30,scale=640:-1" -c:v pam -f image2pipe - | convert -delay 3 - -loop 0 -layers optimize output.gif && alert

start_time=00:40
end_time=01:26

palette="/tmp/palette.png"

filters="fps=30,scale=500:-1:flags=lanczos"
 #ffmpeg -v warning -ss 00:40 -to 01:26 -i fallet.mp4 -vf "fps=fps=15,scale=500:-1:flags=lanczos" animated.gif

ffmpeg -v warning -i $1 -vf "$filters,palettegen" -y $palette
ffmpeg -v warning -ss $start_time -to $end_time -i $1 -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $2


