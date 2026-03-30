#!/bin/zsh
# Force the locale and launch tmux with mutt
export LANG=fr_FR.UTF-8
export LC_ALL=fr_FR.UTF-8
exec tmux -u new-session mutt -F ~/.muttrc
