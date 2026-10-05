#!/bin/sh
cur=$(gsettings get org.gnome.desktop.interface color-scheme)
if [ "$cur" = "'prefer-dark'" ]; then
  gsettings set org.gnome.desktop.interface color-scheme 'default'
else
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
fi
