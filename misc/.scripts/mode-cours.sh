#! /bin/sh

set -x
rm -f ~/.bashrc
ln -s ~/.bashrcdemo ~/.bashrc
source ~/.bashrc
rm -f ~/.vimrc
ln -s ~/.vimrcdemo .vimrc
