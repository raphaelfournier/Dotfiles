#! /bin/bash
echo "-----------------"
echo "vlc v4l2:///dev/video2"
echo "-----------------"
ffmpeg -f v4l2 -i /dev/video1 -pix_fmt yuyv422 -vf "transpose=3" -f v4l2 /dev/video2

# voir dans vlc : vlc v4l2:///dev/video2
