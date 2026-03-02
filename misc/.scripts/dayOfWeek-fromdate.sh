#!/bin/bash

# Input example: "12 mars"
INPUT="$1"
YEAR=$(date +%Y)

# 1. Create a mapping of French months to numbers
# This avoids the "incorrecte" error entirely
case "${INPUT,,}" in # ,, converts to lowercase
  *janvier*)  M=01 ;;
  *février*)  M=02 ;;
  *mars*)     M=03 ;;
  *avril*)    M=04 ;;
  *mai*)      M=05 ;;
  *juin*)     M=06 ;;
  *juillet*)  M=07 ;;
  *août*)     M=08 ;;
  *septembre*) M=09 ;;
  *octobre*)  M=10 ;;
  *novembre*) M=11 ;;
  *décembre*) M=12 ;;
  *)          M="" ;;
esac

# 2. Extract the day number from the input string
DAY=$(echo "$INPUT" | grep -oE '[0-9]+')

# 3. If we found a month and a day, format it for the 'date' command
if [[ -n "$M" && -n "$DAY" ]]; then
  # We pass the date as YYYY-MM-DD which 'date' always understands
  RESULT=$(LC_TIME=fr_FR.UTF-8 date -d "$YEAR-$M-$DAY" "+%A")
  echo "$RESULT $INPUT $YEAR"
else
  # Fallback: if it's already in English or standard format
  RESULT=$(LC_TIME=fr_FR.UTF-8 date -d "$INPUT $YEAR" "+%A" 2>/dev/null)
  if [ $? -eq 0 ]; then
    echo "$RESULT $INPUT $YEAR"
  else
    echo "Erreur : Impossible de lire la date '$INPUT'."
  fi
fi
