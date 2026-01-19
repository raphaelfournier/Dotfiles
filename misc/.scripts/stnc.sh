#!/bin/bash

# Check for minimum arguments
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 [-k] file1 [file2 ...]"
    exit 1
fi

# Initialize variables
KEEP_COPY=false

# Check if the first argument is the flag
if [ "$1" == "-k" ]; then
    KEEP_COPY=true
    shift
fi

# Assign target directories and validate their existence
COPY_DIR=/home/raph/Cloud/NextcloudFS/A-INBOX/
ARCHIVE_DIR=/home/raph/downloads/

# Process each file
for FILE in "$@"; do
    if [ -e "$FILE" ]; then
        cp "$FILE" "$COPY_DIR"
        echo "Copied: $FILE -> $COPY_DIR"
      if ! $KEEP_COPY; then
        mv "$FILE" "$ARCHIVE_DIR"
        echo "Moved: $FILE -> $ARCHIVE_DIR"
      fi
    else
        echo "Error: File '$FILE' does not exist."
    fi
done

