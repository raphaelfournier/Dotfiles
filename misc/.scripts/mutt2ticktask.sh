#!/bin/bash

# 1. Capture the full email from stdin
RAW_EMAIL=$(cat)

# 2. Extract Author and Subject using formail (reliable) 
# or grep/sed (built-in)
#AUTHOR=$(echo "$RAW_EMAIL" | formail -x From: | xargs)
AUTHOR=$(echo "$RAW_EMAIL" | formail -x From: | perl -MEncode -ne 'print Encode::encode("utf-8", Encode::decode("MIME-Header", $_))' | xargs)
DATE=$(echo "$RAW_EMAIL" | formail -x Date: | xargs)
#SUBJECT=$(echo "$RAW_EMAIL" | formail -x Subject: | xargs -0)
SUBJECT=$(echo "$RAW_EMAIL" | formail -x Subject: | xargs -d '\n')

# 3. Get the Maildir (Passed as the first argument from Mutt)
#MAILDIR=$1

if [[ $AUTHOR =~ ^(.+)\ \<(.+)\>$ ]]; then
    full_name="${BASH_REMATCH[1]}"
    email="${BASH_REMATCH[2]}"
fi

date_courte=$(date -d "$DATE" +"%d %b %y à %H:%M")
decoded_subject=$(echo "$SUBJECT" | perl -MEncode -ne 'print Encode::decode("MIME-Header", $_)' | sed -E 's/^\s*(Re: |Fwd: )//gI' )


# 4. Execute your command
#echo -e "Mail de $full_name du $date_courte\n$decoded_subject" >> ~/essai
#echo -e "$decoded_subject\nMail de $full_name du $date_courte\n" >> ~/tests
echo -e "$decoded_subject\nMail de $full_name du $date_courte\n" | ticktask "foobar" && notify-send ticktask -t 3000 "tâche créée" || notify-send ticktask -u critical -t 3000 "not sent"
