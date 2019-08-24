#!/bin/bash

HDMI_OUT="HDMI1"

if xrandr --listmonitors | grep "$HDMI_OUT"; then
  xrandr --output "$HDMI_OUT" --off
  HDMI_STATUS="off"
else
  xrandr --output "$HDMI_OUT" --mode 1920x1080 --right-of eDP1
  HDMI_STATUS="on"
fi

notify-send -h string:x-canonical-private-synchronous:hdmi_status \
  "HDMI: ${HDMI_STATUS}"
