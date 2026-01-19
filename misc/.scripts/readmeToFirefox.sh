#!/bin/bash

# Convert README.md to temporary HTML file
tmp_html=$(mktemp --suffix=.html)
pandoc README.md -o "$tmp_html"

# Open in Firefox
firefox "$tmp_html"
#rm "$tmp_html"
