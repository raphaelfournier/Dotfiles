#! /bin/bash

urxvt -e bash -c 'echo "--- Terminal pour shuttle ---"; sleep 1; exec sshuttle -r fournier@ssh.lip6.fr -x 132.227.74.250 132.227.0.0/16 134.157.0.0/16'


