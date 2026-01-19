#! /bin/bash

xinput --map-to-output 'Wacom Bamboo1 Pen cursor' HDMI-1; xinput --map-to-output 'Wacom Bamboo1 Pen eraser' HDMI-1; xinput --map-to-output 'Wacom Bamboo1 Pen stylus' HDMI-1
xournalpp ~/brouillon-`date +%Y%m%d-%H%M%S`.pdf &
