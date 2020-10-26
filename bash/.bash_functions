function mkcd () { 
  mkdir -p "$@" && eval cd "\"\$$#\""; 
}

function cp_p()
{
 strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
      | awk '{
        count += $NF
            if (count % 10 == 0) {
               percent = count / total_size * 100
               printf "%3d%% [", percent
               for (i=0;i<=percent;i++)
                  printf "="
               printf ">"
               for (i=percent;i<100;i++)
                  printf " "
               printf "]\r"
            }
         }
         END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

function calendrier {
    zathura ~/CNAM/calendrier.pdf
}

function email {
    grep "@" ~/.mutt/aliases | grep -i "$1" | cut -d " " -f3- | sed "s:[<>]::g"
}

function infos { 
    info --vi-keys --subnodes -o - "$@" | less; 
}

cgrep(){
    grep -a "$1" "/home/raph/COMMANDES"
}
