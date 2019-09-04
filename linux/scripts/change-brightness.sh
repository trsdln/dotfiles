#!/bin/bash

BRIGHTNESS_CHANGE=$1

xbacklight ${BRIGHTNESS_CHANGE}

NEW_BRIGHTNESS=$(xbacklight -get | cut -d "." -f1)

notify-send --hint string:x-canonical-private-synchronous:volume \
  "Brightness" "${NEW_BRIGHTNESS}%"
