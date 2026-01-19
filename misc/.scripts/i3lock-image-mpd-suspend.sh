#!/bin/sh
selectedexpression=$(find /home/raph/Images/Wallpapers/LockScreen/ -type f | shuf -n 1)
mpc pause
wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%
wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
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
    --time-color=ccccccb8	\
    \
    --date-str="%A %-e %B"	\
    --date-color=ccccccb8	\
    --date-font="Inconsolata"	\
    --date-size=64		\
    \
    --time-pos="30:h-128"		\
    --date-pos="30:h-50"	\
    --date-align=1	\
    --time-align=1	\
#--image-fill /home/raph/Images/Wallpapers/france_lighthouse_sea_during_sunset_4k_hd_nature.jpg \
