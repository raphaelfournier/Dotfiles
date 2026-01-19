#!/bin/bash

read tmpdir < <(mktemp -d /tmp/print_preview-$USER-XXXXXXXX)
cd $tmpdir || exit 1

trap "cd && rm -fR $tmpdir;exit" 0 1 2 3 6 9 15

cat >file.eml
muttprint -P A4 -p TO_FILE:file.ps <file.eml 

read numPages < <(sed '/^%%Pages/{s/%%Pages: //;q;};d' file.ps)
(( numPages > 1 )) &&
    muttprint -2 -P A4 -p TO_FILE:file.ps <file.eml 

gv file.ps
