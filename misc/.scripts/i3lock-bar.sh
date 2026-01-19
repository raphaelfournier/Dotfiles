#!/bin/bash

selectedexpression=$(find /home/raph/Images/Wallpapers/LockScreen/ | shuf -n 1)
lightdark=`python /home/raph/Images/Wallpapers/light-dark-lockscreen.py $selectedexpression`
# 1 = Dark donc texte clair
if [[ $lightdark -eq 1 ]]
then
  textcolordarkimage="ccccccb8"
else
  textcolordarkimage="222222"
fi
wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%
i3lockmore --nofork  \
    --image-fill $selectedexpression \
    --keyhl-color="ccccccb8" \
    --bshl-color="408020" \
    --ringver-color="208080dd" \
    --ringwrong-color="cc2020dd" \
    --bar-indicator \
    --wrong-text="Erreur !"		\
    --wrong-color="ccccccb8" \
    --bar-total-width=w/3 \
    --bar-pos=w/3:h \
    --verif-text="Vérification..."		\
    --verif-color="ccccccb8" \
    --ind-pos=w/2:h-5 \
    --bar-orientation=horizontal \
    --bar-direction=1 \
    --bar-max-height=30 \
    --bar-base-width=30 \
    --bar-color=00000010 \
    --bar-periodic-step=50 \
    --bar-step=50 \
    --redraw-thread \
    \
    --pass-media-keys \
    --clock			\
    --time-str="%H:%M"	\
    --time-font="Inconsolata"	\
    --time-size=192		\
    --time-color=$textcolordarkimage	\
    \
    --date-str="%A %-e %B"	\
    --date-color=$textcolordarkimage	\
    --date-font="Inconsolata"	\
    --date-size=64		\
    \
    --time-pos="30:h-128"		\
    --date-pos="30:h-50"	\
    --date-align=1	\
    --time-align=1	\
