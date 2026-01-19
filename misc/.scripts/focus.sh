#! /bin/bash

function show_help () {
  echo "coucou"
}

# Initialize our own variables:
defocus=1
verbose=0

#while getopts "h?vf:" opt; do
while getopts "h?vd" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    v)  verbose=1
        ;;
    d)  defocus=0
        ;;
    #f)  output_file=$OPTARG
        #;;
    esac
done

dir="/etc/hosts.d"
file="stayfocused.local"
prefix="11-"

if [ $defocus = 0 ]; then
  if [ -f /etc/hosts.d/11-stayfocused.local ]
  then
    if [ $verbose = 1 ]; then
      echo "mv $dir/$prefix$file $dir/$file && sudo hosts-gen"
    fi
    sudo mv $dir/$prefix$file $dir/$file && sudo hosts-gen
  else
    echo "file $prefix$file not found in $dir"
    echo "Looks like you're already not focused!"
    exit 1
  fi
else
  if [ -f /etc/hosts.d/stayfocused.local ]
  then
    if [ $verbose = 1 ]; then
      echo "mv $dir/$file $dir/$prefix$file && sudo hosts-gen"
    fi
    sudo mv $dir/$file $dir/$prefix$file && sudo hosts-gen
  else
    echo "file $file not found in $dir"
    echo "Looks like you're already in focus mode!"
    exit 1
  fi
fi
