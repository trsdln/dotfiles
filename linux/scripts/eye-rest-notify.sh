#!/bin/sh

export DISPLAY=':0'
export XAUTHORITY=$HOME/.local/share/.Xauthority
/usr/bin/notify-send -u critical -i /usr/share/icons/Paper/32x32/status/dialog-warning.png -h string:x-canonical-private-synchronous:eye-rest  "Eye Rest" "Time to make short break"
