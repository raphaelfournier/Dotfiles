#!/bin/bash
# Projector preview script for AwesomeWM

PREVIEW_WIDTH=1024
PREVIEW_HEIGHT=768
AUTOFIT="${PREVIEW_WIDTH}x${PREVIEW_HEIGHT}"
GEOMETRY="50%:50%"
CLASS_NAME="ProjectorPreview"
PIPE="/tmp/projector_preview_pipe"

HEIGHT=2160
WIDTH=3840
X_OFFSET=0
Y_OFFSET=0

# Clean up on exit
cleanup() {
    rm -f "$PIPE"
}
trap cleanup EXIT INT TERM

# Remove stale pipe and create a new one
rm -f "$PIPE"
mkfifo "$PIPE"

# Launch ffmpeg capture
ffmpeg -y \
    -f x11grab \
    -video_size "${WIDTH}x${HEIGHT}" \
    -i ":0.0+${X_OFFSET},${Y_OFFSET}" \
    -f nut \
    "$PIPE" &

FFMPEG_PID=$!

# Launch mpv preview
mpv \
    --profile=low-latency \
    --untimed \
    --vf="scale=${PREVIEW_WIDTH}:${PREVIEW_HEIGHT}" \
    --autofit="${AUTOFIT}" \
    --geometry="${GEOMETRY}" \
    --x11-name="${CLASS_NAME}" \
    "$PIPE"

# Stop ffmpeg when mpv exits
kill "$FFMPEG_PID" 2>/dev/null
wait "$FFMPEG_PID" 2>/dev/null
