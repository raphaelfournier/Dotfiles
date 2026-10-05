#!/bin/bash

# Find your exact touch device name dynamically
DEVICE=$(xsetwacom --list devices | grep -i "finger" | cut -d':' -f1 | sed 's/[[:space:]]*id$//')
echo $DEVICE

if [ -z "$DEVICE" ]; then
    # Fallback to your exact device name if auto-detection fails
    DEVICE="Wacom HID 4998 Finger touch"
fi
echo $DEVICE

# Get current gesture state
CURRENT_GESTURE=$(xsetwacom --get "$DEVICE" Gesture)
echo $CURRENT_GESTURE

if [ "$CURRENT_GESTURE" = "on" ]; then
    # Turn gestures OFF -> Finger now acts as Left-Click Drag (DRAW MODE)
    xsetwacom --set "$DEVICE" Gesture off
    xsetwacom --set "$DEVICE" Touch on
    notify-send -t 2000 "Touchscreen Mode" "🎨 DRAW MODE (Finger = Paint/Drag)"
else
    # Turn gestures ON -> Finger acts as Pan/Scroll (SCROLL MODE)
    xsetwacom --set "$DEVICE" Gesture on
    notify-send -t 2000 "Touchscreen Mode" "📜 SCROLL MODE (Finger = Pan)"
fi
