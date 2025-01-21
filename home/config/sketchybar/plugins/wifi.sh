#!/bin/sh

SSID="$(ipconfig getsummary en0 | awk -F ' SSID : ' '/ SSID : / {print $2}')"

if [ "$SSID" = "" ]; then
	exit 0
fi

ICON="ᯤ"

sketchybar --set "$NAME" label="$SSID" icon="$ICON" icon.font.size=20 icon.y_offset=3
