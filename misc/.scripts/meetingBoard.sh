#! /bin/bash
echo "Converting $1 to 25% and renaming it"
convert $1 -resize 25% $(exiftool -d "%Y-%m-%d_%H%M%S" -CreateDate $1 | awk '{print "MeetingBoard-"$4".jpg"}')
ls -trl | tail -n1
