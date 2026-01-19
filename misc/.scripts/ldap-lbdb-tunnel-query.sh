#!/bin/bash

# --- Configuration ---
LOCAL_PORT=10389
REMOTE_HOST=publicldap1
REMOTE_PORT=389
JUMP_HOST=fournier@ssh.lip6.fr
#BASE_DN="ou=Teams,dc=lip6,dc=fr"

SEARCH_TERM="$1"

# Start SSH tunnel in background
ssh -L ${LOCAL_PORT}:${REMOTE_HOST}:${REMOTE_PORT} ${JUMP_HOST} -N &
SSH_PID=$!

# Wait for tunnel to establish
sleep 2

# Perform LDAP query in lbdb format (name <email>)
BASE_DN="ou=People,ou=Accounts,dc=lip6,dc=fr"
#ldapsearch -x -H ldap://127.0.0.1:${LOCAL_PORT} \
		#-b "$BASE_DN" -s sub "(cn=*$SEARCH_TERM*)" mail cn \
		#| awk '/^cn: /{name=$2 " " $3} /^mail: /{print name " <" $2 ">"}'

#ldapsearch -x -H ldap://127.0.0.1:10389 -b "dc=lip6,dc=fr" -s sub "(objectClass=*)" dn

# explore all
#ldapsearch -x -H ldap://127.0.0.1:10389 -b "dc=lip6,dc=fr" -s sub "(objectClass=*)" dn \
  #| awk '/^dn: /{gsub(/^dn: /,"");gsub(/,/,",\n");print}' \
  #| awk -F, '{for (i=NF; i>0; i--) {for (j=i; j<NF; j++) printf "  "; print $i}}'

ldapsearch -x -H ldap://127.0.0.1:${LOCAL_PORT} \
		-b "$BASE_DN" -s sub "(cn=*$SEARCH_TERM*)" cn roomNumber mail telephoneNumber lip6team \
	| awk '
/^cn: / {
  sub(/^cn: /, "", $0)
  name = $0
}
/^mail: / {
  sub(/^mail: /, "", $0)
  email = $0
}
/^roomNumber: / {
  sub(/^roomNumber: /, "", $0)
  room = $0
  sub(/^Site[[:space:]]+Jussieu[[:space:]]+/, "", room)
}
/^telephoneNumber: / {
  sub(/^telephoneNumber: /, "", $0)
  phone = $0
}
/^lip6team: / {
  sub(/^lip6team: /, "", $0)
  equipe = $0
}
/^$/ {
  if (name || email || room || phone || equipe) {
    print name " | " email " | " room " | " phone " | " equipe
    name=email=room=phone=equipe=""
  }
}
'

# dumps everything!
#ldapvi --host 127.0.0.1:10389 --base "dc=lip6,dc=fr" 

# Close tunnel
kill $SSH_PID

