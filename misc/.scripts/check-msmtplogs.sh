#! /bin/bash

#tail Mail/logs/msmtp.log | grep -v "EX_OK" | 
if tail ~/Mail/logs/msmtp.log | grep -v "EX_OK" 
then
  echo "ya des erreurs dans les logs"
  echo "tail ~/Mail/logs/msmtp.log | grep -v \"EX_OK\""
  SUBJECT="Erreurs d'envoi"
  BODY=`tail ~/Mail/logs/msmtp.log | grep -v "EX_OK"`
  printf '%s\n' "Subject: ${SUBJECT}" \
     "From: \"msmtp log:\" <sender@example.net>" \
     "" \
     "${BODY}" \
     "" \
     "Have a good day!" | sendmail -oi raph
else
  #SUBJECT="OK"
  #BODY=`tail Mail/logs/msmtp.log`
  echo "rien à signaler dans les logs"
fi
