#!/bin/sh

# Supported modes:
#  - only primary monitor:    [PRIMARY] [    -    ]
#  - 2 side-by-side monitors: [PRIMARY] [SECONDARY]
#  - only secondary monitor:  [   -   ] [SECONDARY]

PRIMARY_OUTPUT="eDP1"
SECONDARY_OUTPUT="HDMI1"

SECONDARY_ENABLED=$(xrandr --listmonitors | grep "${SECONDARY_OUTPUT}")
PRIMARY_ENABLED=$(xrandr --listmonitors | grep "${PRIMARY_OUTPUT}")

if [ "${PRIMARY_ENABLED}" != "" ] && [ "${SECONDARY_ENABLED}" = "" ]; then
  CURRENT_MODE="Only Secondary"
  xrandr --output "${PRIMARY_OUTPUT}" --off \
    --output "${SECONDARY_OUTPUT}" --auto
elif [ "${PRIMARY_ENABLED}" = "" ] && [ "${SECONDARY_ENABLED}" != "" ]; then
  CURRENT_MODE="Side-by-Side"
  xrandr --output "${PRIMARY_OUTPUT}" --auto \
    --output "${SECONDARY_OUTPUT}" --auto --right-of "${PRIMARY_OUTPUT}"
else
  CURRENT_MODE="Only Primary"
  xrandr --output "${PRIMARY_OUTPUT}" --auto \
    --output "${SECONDARY_OUTPUT}" --off
fi

notify-send --hint=string:x-canonical-private-synchronous:hdmi-status \
  --icon=/usr/share/icons/Paper/32x32/devices/display.png \
  "Screen Mode" "${CURRENT_MODE}"
