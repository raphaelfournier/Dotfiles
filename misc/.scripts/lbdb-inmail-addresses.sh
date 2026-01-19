#!/bin/sh

accounts=( "/home/raph/Mail/Lavabit" "/home/raph/Mail/Paris13" "/home/raph/Mail/Rfnet" )

parsemail () {
    cat $1 | lbdb-fetchaddr
}

parsemaildir () {
    for mailfile in $( find $1 -type f -mtime -205 ) ; do
        parsemail ${mailfile}
    done
}

# The IFS variable saves the file name separator 
# which we will temporarily set to \n so that the
# spaces in Gmail folders will work

for i in "${accounts[@]}" ; do 
    echo $i
    o=${IFS}
    IFS=$(echo -en "\n\b")
    parsemaildir "${i}"
    IFS=o
done

# remove dups
SORT_OUTPUT=name /usr/lib/lbdb-munge
