#! /bin/bash

passwd=`pwgen -c -n -y -N1 20`
cat <(echo $passwd) ~/Templates/passwordstore-entry | sed "s:raphael@:raphael.$1@:" | pass insert -m web/$1 
pass show web/$1
