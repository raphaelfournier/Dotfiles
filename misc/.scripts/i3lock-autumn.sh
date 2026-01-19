#!/bin/sh
mpc pause
i3lockmore --nofork                 \
    --ignore-empty-password	\
    --linecolor=000000        \
    --keyhlcolor=ebcb8b       \
    --bshlcolor=d8dee9	\
    --separatorcolor=000000   \
    --radius=30			\
    --indpos="240:300"		\
    \
    --insidevercolor=000000	\
    --insidewrongcolor=000000 \
    --insidecolor=000000	\
    \
    --ringcolor=e59d17        \
    --ringvercolor=a3be8c     \
    --ringwrongcolor=bf616a   \
    \
    --clock			\
    --timecolor=eceff4ff	\
    --timestr="%H:%M"	\
    --time-font="Inconsolata"	\
    --timesize=192		\
    --timepos="10:140"		\
    --timecolor=2e3440ff	\
    --time-align=1	\
    \
    --datecolor=d8dee9ff	\
    --datestr="%A %-e %B"	\
    --datecolor=2e3440ff	\
    --date-font="Inconsolata"	\
    --datesize=64		\
    --datepos="10:226"	\
    --date-align="1"	\
    \
    --veriftext=""		\
    --wrongtext=""		\
    \
    --tiling		\
    --image-fill /home/raph/Images/Wallpapers/EarthPornReddit/Landscape/t9k1v0s9qq431.jpg

    #--image-fill /home/raph/Images/Wallpapers/EarthPornReddit/Landscape/t9k1v0s9qq431.jpg
    # --image=/home/raph/Images/Wallpapers/EarthPornReddit/Landscape/koj6p0p39n031.png 
    #--image=/home/raph/Images/Wallpapers/lock-wallpaper.png
    #--indicator			\
    #\
