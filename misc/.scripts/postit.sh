#!/bin/bash

CONFIG_FILE="$HOME/.config/alacritty/sticky-notes.toml"
STICKY_NOTE_FILE="$HOME/.sticky-note"

echo "$@" > "$STICKY_NOTE_FILE"

alacritty --config-file "$CONFIG_FILE"
