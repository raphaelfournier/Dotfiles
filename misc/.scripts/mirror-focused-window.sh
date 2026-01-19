#!/usr/bin/env bash

xdotool getwindowfocus | xargs -I% gst-launch-1.0 ximagesrc xid=% ! videoconvert ! autovideosink
