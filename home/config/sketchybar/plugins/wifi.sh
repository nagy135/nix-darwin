#!/bin/sh

SSID="$(ipconfig getsummary en0 | awk -F ' SSID : ' '/ SSID : / {print $2}')"

if [ "$SSID" = "<redacted>" ]; then
	SSID=""
fi

ICON="📶"

if [ -z "$SSID" ]; then
	sketchybar --set "$NAME" label="$SSID" icon="$ICON" icon.y_offset=0 \
		label.padding_left=0 label.padding_right=0
else
	sketchybar --set "$NAME" label="$SSID" icon="$ICON" icon.y_offset=0 \
		label.padding_left=4 label.padding_right=4
fi
