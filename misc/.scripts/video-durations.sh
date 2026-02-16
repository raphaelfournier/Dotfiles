#!/bin/bash

# Check for exiftool
if ! command -v exiftool &> /dev/null; then
    echo "Error: exiftool is not installed."
    exit 1
fi

TARGET_DIR="${1:-.}"
total_seconds=0

echo "Scanning: $TARGET_DIR"
echo "------------------------------------------------"

shopt -s nullglob
shopt -s nocaseglob

for file in "$TARGET_DIR"/*.{mp4,webm}; do
    # Get duration in a format easy to math (seconds)
    # -n returns the raw numeric value in seconds
    seconds=$(exiftool -s3 -n -Duration "$file")

    if [ -n "$seconds" ]; then
        # Display individual file duration in human-readable format
        readable=$(exiftool -s3 -Duration "$file")
        echo "File: $(basename "$file")"
        echo "Duration: $readable"
        echo "------------------------------------------------"

        # Add to total (using bc for decimal handling if necessary)
        total_seconds=$(echo "$total_seconds + $seconds" | bc)
    fi
done

# Convert total seconds back to HH:MM:SS
if (( $(echo "$total_seconds > 0" | bc -l) )); then
    # Round to nearest integer for display
    rounded_total=$(LC_NUMERIC=C printf "%.0f" "$total_seconds")
    
    final_time=$(printf '%02d:%02d:%02d\n' $((rounded_total/3600)) $((rounded_total%3600/60)) $((rounded_total%60)))
    
    echo "TOTAL DURATION: $final_time"
    echo "------------------------------------------------"
else
    echo "No supported video files found."
fi

shopt -u nocaseglob
shopt -u nullglob
