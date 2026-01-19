#! /bin/bash

wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
wpctl set-volume @DEFAULT_AUDIO_SINK@ 34%
mpc clear 
mpc load work
mpc random off
mpc repeat on
mpc play; mpc stop

#mpc searchplay artist 'Korn' title 'Dead'
mpc searchplay filename 'denzel'
