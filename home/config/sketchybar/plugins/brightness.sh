#!/bin/sh

# The brightness_change event supplies a $INFO variable in which the current brightness
# percentage is passed to the script.

if [ "$SENDER" = "brightness_change" ]; then
  BRIGHTNESS="$INFO"

  case "$BRIGHTNESS" in
    [6-9][0-9]|100) ICON="🔆"
      ;;
    [3-5][0-9]) ICON="🔅"
      ;;
    [1-9]|[1-2][0-9]) ICON="🌤️"
      ;;
    *) ICON="🌑"
  esac

  sketchybar --set "$NAME" icon="$ICON" label="$BRIGHTNESS%" icon.y_offset="1"
fi
