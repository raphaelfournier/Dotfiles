#!/bin/bash

# Start xpra session
xpra start :108

# Launch the browser in the xpra session
DISPLAY=:108 chromium &

# Attach the xpra session as a window on the main display
xpra attach :108
