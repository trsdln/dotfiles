#!/bin/sh

KEYBOARD_LAYOUT="$(setxkbmap -query | awk '/layout/ {print $2}')"

if [ "${KEYBOARD_LAYOUT}" = 'us' ]; then
  setxkbmap -model thinkpad -layout ua -variant legacy
  # "legacy" variant fixes problem with ? vs . at UA keyboard
else
  # Set keyboard layout
  setxkbmap us -model thinkpad -layout us
fi

# update status line
SCRIPTS_DIR=$(dirname "$0")
$SCRIPTS_DIR/statusline/widgets/language.sh
