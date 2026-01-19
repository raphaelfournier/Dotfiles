#!/bin/bash
# a simple script to restart offlineimap if it's died

if [ $(pgrep offlineimap | wc -l) -eq 0 ] ; then
  offlineimap -u Noninteractive.Quiet &
  exit 0
else
  exit 0
fi

exit 0
