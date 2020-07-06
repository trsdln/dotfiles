#!/bin/sh

SCRIPTS_DIR=$(dirname "$0")
. $SCRIPTS_DIR/../configs.sh

KEYBOARD_LAYOUT="$(setxkbmap -query | awk '/layout/ {print toupper($2)}')"
if [ $KEYBOARD_LAYOUT = "UA" ]; then
  KEYBOARD_LAYOUT_COLOR=$YELLOW_COLOR
else
  KEYBOARD_LAYOUT_COLOR=$BLUE_COLOR
fi

echo "L%{F$KEYBOARD_LAYOUT_COLOR}$(wrap_self_edit "${KEYBOARD_LAYOUT}")%{F-}" > "${PANEL_FIFO}"
