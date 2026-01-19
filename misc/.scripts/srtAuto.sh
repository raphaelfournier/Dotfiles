#! /bin/sh
command="cat > /mnt/Data/Downloaded/"
unzip -cbq $1 | ssh raph@rfournier.homelinux.org "${command}$2.srt"
