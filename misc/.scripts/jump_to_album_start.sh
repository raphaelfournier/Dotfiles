#!/bin/bash

# Get the current album name
current_album=$(mpc -f %album% current)

# Find the index of the first track of the album in the playlist
track_index=$(mpc playlist -f "[%position%] %album%" | grep -m 1 "$current_album" | awk '{print $1}')

# If a track index was found, play it
if [ -n "$track_index" ]; then
    mpc play "$track_index"
else
    echo "No tracks from the current album found in the playlist."
fi
