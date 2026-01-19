#!/bin/sh

echo "Choix d'un profil :"
read -p "(H)Home (L)Labo (T)Tardieres (N)Skip [H]: "  reply
[ -z $reply ] && reply="H"
case $reply in
    H*|h*)
    sudo netcfg home
    ;;
    L*|l*)
    sudo dhcpcd eth0
    ;;
    T*|t*)
    sudo netcfg tardieres
    ;;
    N*|n*)
    echo "Skipping"
    ;;
esac
