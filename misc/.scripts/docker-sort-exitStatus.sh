#! /bin/bash

docker ps -a --format "{{.Status}}\t{{.ID}}\t{{.Names}}\t{{printf \"%.25s\" .Image}}\t{{.Ports}}" \
  | awk -F'\t' '{printf "%s\t%s\t%s\t%s\t%s\n", $1, $2, $3, $4, $5;}' \
  | awk -F'\t' '{system("date --rfc-3339=seconds -u -d \"$(printf \"" $1 "\" | cut -d \" \" -f3-5 | sed \"s/about//g\") \" | tr -d \"\n\"") ; printf "\t%s\t%s\t%s\t%s\t%s\n", $1, $2, $3, $4, $5;}' \
  | sort -r \
  | awk -F'\t' 'BEGIN{printf "%s\t%s\t%s\t%s\t%s\n", "ID", "NAMES", "STATUS", "IMAGE", "PORTS";}{ printf "%s\t%s\t%s\t%s\t%s\n", $3, $4, $2, $5, $6;}' \
  | column -o " " -t -s $'\t'
