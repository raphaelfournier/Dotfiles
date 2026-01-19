#!/bin/bash
# Projector preview script for AwesomeWM

# Optional: scale for preview window
PREVIEW_WIDTH=1024
PREVIEW_HEIGHT=768
AUTOFIT="${PREVIEW_WIDTH}x${PREVIEW_HEIGHT}"
GEOMETRY="50%:50%"
CLASS_NAME="ProjectorPreview"
PIPE="/tmp/projector_preview_pipe"

HEIGHT=1080
WIDTH=1920
X_OFFSET=0
Y_OFFSET=0

# Create named pipe
if [ -p "$PIPE" ]; then
    rm "$PIPE"
fi
mkfifo "$PIPE"

# Launch ffmpeg capture
ffmpeg -f x11grab -video_size "${WIDTH}x${HEIGHT}" -i ":0.0+${X_OFFSET},${Y_OFFSET}" -f nut "$PIPE" &

# Launch mpv preview
mpv --profile=low-latency --untimed \
    --vf=scale=${PREVIEW_WIDTH}:${PREVIEW_HEIGHT} \
    --autofit=${AUTOFIT} \
    --geometry=${GEOMETRY} \
    --x11-name=${CLASS_NAME} \
    "$PIPE"

# Cleanup
rm "$PIPE"
