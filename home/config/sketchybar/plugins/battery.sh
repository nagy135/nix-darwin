#!/bin/sh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100) ICON="🔋"
  ;;
  [5-8][0-9]) ICON="🔋"
  ;;
  [2-4][0-9]) ICON="🔋🟧"
  ;;
  1[1-9]) ICON="🔋🟧🟧"
  ;;
  10|[0-9]) 
    RED_SQUARES=$((10 - PERCENTAGE + 1))
    ICON="🔋"
    for i in $(seq 1 "$RED_SQUARES"); do
      ICON="${ICON}🟥"
    done
  ;;
  *) ICON="🔋"
esac

if [[ "$CHARGING" != "" ]]; then
  ICON="🔌"
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%"
