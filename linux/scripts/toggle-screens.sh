#!/bin/sh

# Supported modes:
#  - only primary monitor:    [PRIMARY] [    -    ]
#  - 2 side-by-side monitors: [PRIMARY] [SECONDARY]
#  - only secondary monitor:  [   -   ] [SECONDARY]

PRIMARY_OUTPUT="eDP1"
SECONDARY_OUTPUT="HDMI1"

MONITORS_LIST=$(xrandr --listmonitors)
SECONDARY_ENABLED=$(echo "${MONITORS_LIST}" | grep "${SECONDARY_OUTPUT}")
PRIMARY_ENABLED=$(echo "${MONITORS_LIST}" | grep "${PRIMARY_OUTPUT}")
SECONDARY_DISCONNECTED=$(xrandr | grep "${SECONDARY_OUTPUT} disconnected")

set_only_primary_mode() {
  CURRENT_MODE="Only Primary"
  xrandr --output "${PRIMARY_OUTPUT}" --auto \
    --output "${SECONDARY_OUTPUT}" --off
}

set_only_secondary_mode() {
  CURRENT_MODE="Only Secondary"
  xrandr --output "${PRIMARY_OUTPUT}" --off \
    --output "${SECONDARY_OUTPUT}" --auto
}

set_side_by_side_mode() {
  CURRENT_MODE="Side-by-Side"
  xrandr --output "${PRIMARY_OUTPUT}" --auto \
    --output "${SECONDARY_OUTPUT}" --auto --right-of "${PRIMARY_OUTPUT}"
}

if [ "${SECONDARY_DISCONNECTED}" = "" ]; then
  if [ "${PRIMARY_ENABLED}" != "" ] && [ "${SECONDARY_ENABLED}" = "" ]; then
    set_only_secondary_mode
  elif [ "${PRIMARY_ENABLED}" = "" ] && [ "${SECONDARY_ENABLED}" != "" ]; then
    set_side_by_side_mode
  else
    set_only_primary_mode
  fi
else
  set_only_primary_mode
fi

notify-send --hint=string:x-canonical-private-synchronous:hdmi-status \
  --icon=/usr/share/icons/Paper/32x32/devices/display.png \
  "Screen Mode" "${CURRENT_MODE}"
