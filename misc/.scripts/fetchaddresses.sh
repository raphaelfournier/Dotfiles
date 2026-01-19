#!/bin/bash

find /home/raph/Mail/Paris13/INBOX -type f -mtime -7 -print0 | xargs -0 -n 1 -r /bin/bash -c 'lbdb-fetchaddr -a < "$1"' lbdb-fetchaddr
find /home/raph/Mail/Lavabit/INBOX -type f -mtime -7 -print0 | xargs -0 -n 1 -r /bin/bash -c 'lbdb-fetchaddr -a < "$1"' lbdb-fetchaddr
#find /home/raph/Mail/gmail/INBOX -type f -mtime -7 -print0 | xargs -0 -n 1 -r /bin/bash -c 'lbdb-fetchaddr -a < "$1"' lbdb-fetchaddr

# remove dups
SORT_OUTPUT=name /usr/lib/lbdb/lbdb-munge

Lavabit/Archive
Lavabit/Inbox
Lavabit/Sent
Paris13/Archives
Paris13/INBOX
Rfnet/Administratif
Rfnet/Drafts
Rfnet/[Gmail]
Rfnet/INBOX
Rfnet/MLEnsica
Rfnet/Perso
Rfnet/Sent
