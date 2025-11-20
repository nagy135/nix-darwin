#!/bin/sh


if [ "$SENDER" = "media_change" ]; then
  MEDIA="$INFO"

  sketchybar --set "$NAME" label="display=$MEDIA"

else
  sketchybar --set "$NAME" label="elsedisplay=$INFO"
fi
