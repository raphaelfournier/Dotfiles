#!/bin/bash

# Check if at least one file was provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 file1.pdf file2.pdf ..."
    exit 1
fi

# Define the output file name
OUTPUT="result.pdf"
FILES_TO_MERGE=()

# Loop through arguments to build the command
for file in "$@"; do
    if [[ -f "$file" ]]; then
        # Use ghostscript syntax to select only the first page of each file
        # We wrap each file in this syntax for the final command
        FILES_TO_MERGE+=("-dFirstPage=1 -dLastPage=1 \"$file\"")
    else
        echo "Warning: '$file' not found. Skipping."
    fi
done

# Run Ghostscript to merge the pages
# -q: quiet mode, -dNOPAUSE/BATCH: exit after finish, -sDEVICE: output type
eval gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=$OUTPUT ${FILES_TO_MERGE[@]}

echo "---"
echo "Process complete!"
echo "The first pages have been merged into: $OUTPUT"
