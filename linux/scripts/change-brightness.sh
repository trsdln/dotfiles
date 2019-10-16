#!/bin/sh

BRIGHTNESS_CHANGE=$1

xbacklight ${BRIGHTNESS_CHANGE}

NEW_BRIGHTNESS=$(xbacklight -get | cut -d "." -f1)

notify-send --hint=string:x-canonical-private-synchronous:volume \
  --icon=/usr/share/icons/Paper/32x32/status/weather-clear.png \
  "Brightness" "${NEW_BRIGHTNESS}%"
