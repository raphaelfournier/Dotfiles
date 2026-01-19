#!/bin/bash
#
# pbrisbin 2010
# rfs 2019
# rewritten based on ideas from falconindy's SquashFu:
# http://github.com/falconindy/SquashFu
#
###

message() { echo 'usage: backup [ -d | -m | -w ]'; exit 1; }
errorout() { echo "error: $*" >&2; exit 1; }

#backup_folder="/external"
backup_folder="/run/media/raph/Samsung_T5"
backup_daily="$backup_folder/`date +%Y-%m-%d`"

includes=(/home/raph)
excludes=(lost+found .cache .local/share/Trash/)

# default
backup_dir="${backup_dir:-$backup_daily}"

# initial checks
#[[ $(id -u) -eq 0 ]] || errorout 'only root can do that...'
[[ -f "$backup_dir/.lock" ]] || errorout "$backup_dir/.lock not found, is it mounted?"

echo "syncing directories to $backup_dir/"
#echo "rsync -avz --no-p --no-o --no-g -l \"${includes[@]}" ${excludes[@]/#/--exclude } \"
rsync -avz --no-p --no-o --no-g -l "${includes[@]}" ${excludes[@]/#/--exclude } "$backup_dir/" 2>&1 > ~/logBackup`date +%Y-%m-%dT%H:%M`

echo 'generating package lists...'
pacman -Qqe | grep -Fvx "$(pacman -Qqm)" > "$backup_dir/paclog" || errorout 'failed creating paclisting'
pacman -Qqm > "$backup_dir/aurlog" || errorout 'failed creating aur listing'
date > "$backup_dir/date"

echo 'End of rsync. Done!'
