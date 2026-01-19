#!/bin/sh
DIR='/home/davide/coding/projects/cli_utils/thunder_task'
normal=`sh $DIR/task_reader.sh normal | wc -l`
low=`sh $DIR/task_reader.sh low | wc -l`
high=`sh $DIR/task_reader.sh high | wc -l`

if [ "$1" == "html" ]; then
  echo "<span color=red>$high</span>/<span color=white>$normal</span>/<span color=blue>$low</span>"
else
  echo "$high $normal $low"
fi
