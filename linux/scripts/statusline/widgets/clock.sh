#!/bin/sh

SCRIPTS_DIR=$(dirname "$0")
. $SCRIPTS_DIR/../configs.sh

LOCAL_TIME="$(date '+%a %d %b(%m) %H:%M')"
# NY_TIME="$(TZ='America/New_York' date '+%a %H:%M')"
SHOW_CAL_CMD="alacritty --class ShowCal,ShowCal -e show-cal.sh"

echo "C%{F$CYAN_COLOR}%{A:${SHOW_CAL_CMD}:}$(wrap_self_edit "${LOCAL_TIME}")%{A}%{F-}" > "${PANEL_FIFO}"
