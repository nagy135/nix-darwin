#!/bin/sh

SSID="$(ipconfig getsummary en0 | awk -F ' SSID : ' '/ SSID : / {print $2}')"

if [ "$SSID" = "<redacted>" ]; then
	SSID=""
fi

ICON="📶"

sketchybar --set "$NAME" label="$SSID" icon="$ICON" icon.y_offset=0
