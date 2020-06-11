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

LEMONBAR_HEIGHT=20
INIT_DELAY=3

# When switching from single screen to side-by-side
# lemonbar doesn't pick up second screen, so we need restart it
. statusline-restart.sh

set_only_primary_mode() {
  CURRENT_MODE="Only Primary"
  xrandr --output "${PRIMARY_OUTPUT}" --auto \
    --output "${SECONDARY_OUTPUT}" --off

  sleep $INIT_DELAY
  bspc monitor "${PRIMARY_OUTPUT}" -d 1 2 3 4 5 6 7 8 9 0
  bspc config -m "${PRIMARY_OUTPUT}" top_padding ${LEMONBAR_HEIGHT}
  statusline_restart
}

set_only_secondary_mode() {
  CURRENT_MODE="Only Secondary"
  xrandr --output "${PRIMARY_OUTPUT}" --off \
    --output "${SECONDARY_OUTPUT}" --auto

  sleep $INIT_DELAY
  bspc monitor "${SECONDARY_OUTPUT}" -d 1 2 3 4 5 6 7 8 9 0
  bspc config -m "${SECONDARY_OUTPUT}" top_padding ${LEMONBAR_HEIGHT}
  statusline_restart
}

set_side_by_side_mode() {
  CURRENT_MODE="Side-by-Side"
  xrandr --output "${PRIMARY_OUTPUT}" --auto \
    --output "${SECONDARY_OUTPUT}" --auto --right-of "${PRIMARY_OUTPUT}"

  sleep $INIT_DELAY
  bspc monitor "${PRIMARY_OUTPUT}"   -d 1 2 3 4 5
  bspc monitor "${SECONDARY_OUTPUT}" -d 6 7 8 9 0
  bspc config top_padding ${LEMONBAR_HEIGHT}
  statusline_restart
}

# --fix flag support (is used by lock-screen.sh)
if [ "$1" = "--fix" ]; then
  if [ "${SECONDARY_DISCONNECTED}" != "" ]; then
    set_only_primary_mode
  fi
  exit 0
fi

# --init set preferred initial configuration
if [ "$1" = "--init" ]; then
  if [ "${SECONDARY_DISCONNECTED}" = "" ]; then
    set_only_secondary_mode
  else
    # if secondary disconnected call this function anyway
    # to get bspwm workspaces initialized
    set_only_primary_mode
  fi
  exit 0
fi

# screen mode toggle logic
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
