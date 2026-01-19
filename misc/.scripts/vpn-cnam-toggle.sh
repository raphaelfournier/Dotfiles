#! /bin/bash

status=$(nmcli -f GENERAL.STATE con show "VPN CNAM")

if [ ! -z "$status" ]; then
  #echo "connecté"
  nmcli con down id "VPN CNAM"
  notify-send "Déconnexion de VPN CNAM"
else
  #echo "non connecté"
  nmcli con up id "VPN CNAM" passwd-file .vpncnam-secrets
  notify-send "Connexion à VPN CNAM"
fi
  
