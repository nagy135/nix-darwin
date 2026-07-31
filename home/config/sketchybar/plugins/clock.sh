#!/bin/sh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

sketchybar --set "$NAME" label="$(date '+%A %d/%m %H:%M')"

METRICS="$(macmon pipe --samples 1 --interval 500 2>/dev/null)" || exit 0

TEMP="$(printf '%s\n' "$METRICS" | jq -r '.temp.cpu_temp_avg | round')"
CPU="$(printf '%s\n' "$METRICS" | jq -r '.cpu_usage_ratio * 100 | round | if . > 100 then 100 elif . < 0 then 0 else . end')"
RAM="$(printf '%s\n' "$METRICS" | jq -r '.memory | .ram_usage / .ram_total * 100 | round | if . > 100 then 100 elif . < 0 then 0 else . end')"

case "$TEMP:$CPU:$RAM" in
	*[!0-9:]*) exit 0 ;;
esac

TEMP_COLOR=0xffffffff
[ "$TEMP" -ge 80 ] && TEMP_COLOR=0xffffa500
[ "$TEMP" -ge 90 ] && TEMP_COLOR=0xffff453a

CPU_COLOR=0xffffffff
[ "$CPU" -ge 80 ] && CPU_COLOR=0xffffa500
[ "$CPU" -ge 90 ] && CPU_COLOR=0xffff453a

RAM_COLOR=0xffffffff
[ "$RAM" -ge 80 ] && RAM_COLOR=0xffffa500
[ "$RAM" -ge 90 ] && RAM_COLOR=0xffff453a

sketchybar --set temperature label="${TEMP}°C" label.color="$TEMP_COLOR" \
	--set cpu_usage label="${CPU}%" label.color="$CPU_COLOR" \
	--set ram_usage label="${RAM}%" label.color="$RAM_COLOR"
