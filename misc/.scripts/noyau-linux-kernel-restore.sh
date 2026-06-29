#! /bin/bash

URL_FILE1="https://archive.archlinux.org/packages/l/linux/linux-6.13.8.arch1-1-x86_64.pkg.tar.zst"
URL_FILE2="https://archive.archlinux.org/packages/l/linux-headers/linux-headers-6.13.8.arch1-1-x86_64.pkg.tar.zst"

if [ ! -f /var/cache/pacman/pkg/linux-6.13.8.arch1-1-x86_64.pkg.tar.zst] 
then
  wget $URL_FILE1
  wget $URL_FILE2
  sudo mv linux-6.13.8.arch1-1-x86_64.pkg.tar.zst linux-headers-6.13.8.arch1-1-x86_64.pkg.tar.zst /var/cache/pacman/pkg
else
  echo "*** fichiers en place…"
fi

echo "*** installation…"
cd /var/cache/pacman/pkg ; sudo pacman -U linux-6.13.8.arch1-1-x86_64.pkg.tar.zst linux-headers-6.13.8.arch1-1-x86_64.pkg.tar.zst
