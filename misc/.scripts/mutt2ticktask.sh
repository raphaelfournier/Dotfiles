#!/bin/bash
# Mutt → TickTick : transforme le mail reçu sur stdin en tâche.

# 1. Capturer le mail complet depuis stdin
RAW_EMAIL=$(cat)

# 2. Décoder un en-tête de façon fiable :
#    - formail -c recolle les en-têtes repliés sur plusieurs lignes
#    - perl -CS lit ET écrit en UTF-8 (c'était la cause des « � »)
#    - decode("MIME-Header") traite les =?UTF-8?Q?...?= / =?ISO-8859-1?B?...?=
#    - sed supprime les espaces en début/fin (remplace xargs, qui casse sur les apostrophes)
decode_header() {
    printf '%s\n' "$RAW_EMAIL" \
        | formail -c -x "$1" \
        | perl -CS -MEncode -ne 'print Encode::decode("MIME-Header", $_)' \
        | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//'
}

AUTHOR=$(decode_header From:)
DATE=$(decode_header Date:)
SUBJECT=$(decode_header Subject:)

# 3. Nom et adresse de l'expéditeur
re='^(.*)<([^>]+)>$'
if [[ $AUTHOR =~ $re ]]; then
    full_name=$(sed -E 's/^[[:space:]"]+|[[:space:]"]+$//g' <<< "${BASH_REMATCH[1]}")
    email=${BASH_REMATCH[2]}
else
    email=$AUTHOR            # en-tête du type « From: jean@exemple.fr »
fi
full_name=${full_name:-$email}

# 4. Date courte et sujet nettoyé (supprime aussi les « Re: Re: », « Fwd: », « TR: »…)
date_courte=$(date -d "$DATE" +"%d %b %y à %H:%M")
subject=$(sed -E 's/^((re|fwd?|tr)[[:space:]]*:[[:space:]]*)+//I' <<< "$SUBJECT")

# 5. Envoi vers TickTick
if printf '%s\nMail de %s du %s\n\n' "$subject" "$full_name" "$date_courte" | ticktask "foobar"; then
    notify-send -t 3000 ticktask "tâche créée"
else
    notify-send -u critical -t 3000 ticktask "not sent"
fi
