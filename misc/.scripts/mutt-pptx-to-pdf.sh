#! /bin/bash

ATTACHMENT_PATH="/tmp/attachment.pptx"
cat > "$ATTACHMENT_PATH"

loimpress --headless --convert-to pdf "$ATTACHMENT_PATH" 

zathura ~/attachment.pdf
