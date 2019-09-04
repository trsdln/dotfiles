#!/bin/dash

KEYBOARD_LAYOUT="$(setxkbmap -query | awk '/layout/ {print $2}')"

if [ "${KEYBOARD_LAYOUT}" = 'us' ]; then
  setxkbmap -model thinkpad -layout ua -variant legacy
else
  setxkbmap us -model thinkpad -layout us
fi

statusline-update.sh
