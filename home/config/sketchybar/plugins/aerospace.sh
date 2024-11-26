#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$AEROSPACE_FOCUSED_WORKSPACE" ]; then
	sketchybar --set $NAME background.drawing=on label.color=0xff0b0b0b
else
	sketchybar --set $NAME background.drawing=off label.color=0xffffffff
fi
