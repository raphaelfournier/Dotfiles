#! /bin/bash
less ~/.local/share/evolution/tasks/system/tasks.ics | grep "^\(SUMMARY\|PRIO\)"| cut -d ":" -f2- | sed '$!N;s/.\n/ | /' | awk '{FS=" " ; print $NF"|"$0}'| sort -n | cut -d"|" -f2
