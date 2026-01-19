#! /bin/bash

echo "checking neuma-dev.huma-num.fr..."
#if ping -c 3 neuma-dev.huma-num.fr &> /dev/null
CODE=`curl -s -o /dev/null -w "%{http_code}\n"  neuma-dev.huma-num.fr`
if [[ $CODE -ne 000 ]]
then
  if [[ $CODE -eq 502 ]]
  then
    RESULT="error"
  else
    RESULT="success"
  fi
  echo "$RESULT"
else
    RESULT="not connected"
fi
printf '%s\n' "Subject: ${RESULT}" \
   "From: \"FACETS-check:\" <sender@example.net>" \
   "" \
   "FACETS up: ${RESULT}" \
   "" \
   "Have a good day!" | sendmail -oi raph
