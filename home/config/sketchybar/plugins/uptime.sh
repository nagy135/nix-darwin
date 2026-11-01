#!/bin/sh

BOOT_TIME="$(sysctl -n kern.boottime | awk '{printf "%.0f", $4}')"
case "$BOOT_TIME" in
	''|*[!0-9]*) exit 0 ;;
esac

SECONDS_UP=$(($(date +%s) - BOOT_TIME))
if [ "$SECONDS_UP" -ge 86400 ]; then
	VALUE=$((SECONDS_UP / 86400))
	UNIT=d
elif [ "$SECONDS_UP" -ge 3600 ]; then
	VALUE=$((SECONDS_UP / 3600))
	UNIT=h
else
	VALUE=$((SECONDS_UP / 60))
	UNIT=m
fi

ICON=
ICON_COLOR=0xffffffff
if [ "$SECONDS_UP" -gt 1209600 ]; then
	ICON=
	ICON_COLOR=0xffff453a
elif [ "$SECONDS_UP" -gt 604800 ]; then
	ICON=
	ICON_COLOR=0xffffa500
fi

sketchybar --set "$NAME" label="up ${VALUE}${UNIT}" icon="$ICON" icon.color="$ICON_COLOR"
