#! /bin/bash

wmctrl -lpG | sort -k2,2n | awk '{printf $2+1" "$3""FS;for(i=9;i<=NF;++i)printf $i""FS ; print ""}' | column -t -l3
echo
echo 'local s = awful.screen.focused(); local result = {}; for i, t in ipairs(s.tags) do table.insert(result, i .. ": " .. (t.name or "unnamed")) end; return table.concat(result, ", ")' | awesome-client


