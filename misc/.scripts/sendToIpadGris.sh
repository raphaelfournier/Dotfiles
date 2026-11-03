#!/bin/bash
# https://claude.ai/chat/999af80c-79da-4eb9-b1be-7f2ee8b71d08

COPY_DIR="$HOME/Cloud/IpadGris-IcloudRclone"
ARCHIVE_DIR="$HOME/downloads/"
SERVICE=ipad-sync.service

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 [-k] file1 [file2 ...]" >&2
    exit 1
fi

KEEP_COPY=false
if [ "$1" == "-k" ]; then
    KEEP_COPY=true
    shift
fi

COPIED=0
ERRORS=0

for FILE in "$@"; do
    if [ -e "$FILE" ]; then
        if cp -- "$FILE" "$COPY_DIR"; then
            echo "Copied: $FILE -> $COPY_DIR"
            COPIED=$((COPIED + 1))
            if ! $KEEP_COPY; then
                mv -- "$FILE" "$ARCHIVE_DIR" && echo "Moved: $FILE -> $ARCHIVE_DIR"
            fi
        else
            echo "Error: could not copy '$FILE'." >&2
            ERRORS=$((ERRORS + 1))
        fi
    else
        echo "Error: File '$FILE' does not exist." >&2
        ERRORS=$((ERRORS + 1))
    fi
done

# Nothing copied: no need to sync
if [ "$COPIED" -eq 0 ]; then
    notify-send -u critical "iPad sync" "No file copied, sync skipped."
    exit 1
fi

notify-send "Starting Ipad sync..."
START_TS=$(date '+%Y-%m-%d %H:%M:%S')

if systemctl --user start "$SERVICE"; then
    MSG="$COPIED file(s) sent to iCloud."
    [ "$ERRORS" -gt 0 ] && MSG="$MSG ($ERRORS error(s) before sync, see terminal)"
    notify-send "iPad sync ✓" "$MSG"
    echo "Sync OK."
else
    LOG=$(journalctl --user -u "$SERVICE" --since "$START_TS" -o cat --no-pager | tail -n 3)
    notify-send -u critical "iPad sync ✗" "Sync failed:\n$LOG"
    echo "Sync failed. Details: journalctl --user -u $SERVICE --since \"$START_TS\"" >&2
    exit 1
fi
