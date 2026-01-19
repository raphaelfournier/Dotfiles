#! /bin/bash

LOCAL_PORT=10389
REMOTE_HOST=publicldap1
REMOTE_PORT=389
JUMP_HOST=fournier@ssh.lip6.fr
BASE_DN="ou=People,ou=Accounts,dc=lip6,dc=fr"

SEARCH_TERM="$1"

# Start SSH tunnel in background
ssh -L ${LOCAL_PORT}:${REMOTE_HOST}:${REMOTE_PORT} ${JUMP_HOST} -N &
SSH_PID=$!

# Wait a moment for tunnel to establish
sleep 5

# Run the ldapsearch command
#ldapsearch -x -H ldap://127.0.0.1:${LOCAL_PORT} -b "$BASE_DN" -s sub "(cn=*$SEARCH_TERM*)" mail cn | awk '/^cn: /{name=$2 $3} /^mail: /{print name " <" $2 ">"}'

ldapsearch -x -H ldap://127.0.0.1:${LOCAL_PORT} -b  "$BASE_DN" -s sub "(cn=*$SEARCH_TERM*)" mail cn | awk '/^cn: /{name=$2 " " $3} /^mail: /{print name " <" $2 ">"}'

# Kill the SSH tunnel
#kill $SSH_PID
