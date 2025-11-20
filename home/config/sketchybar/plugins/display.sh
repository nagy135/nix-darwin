#!/bin/sh


DISPLAY="$INFO"

ICON=""
NUM_DISPLAYS=$(sketchybar --query displays | jq '. | length')
[[ "$DISPLAY" == "1" && $NUM_DISPLAYS -gt 1 ]] && ICON="🎯"

sketchybar --set "$NAME" label="$ICON" icon.font.size=25 y_offset="3" padding_left="-3" padding_right="-3"
