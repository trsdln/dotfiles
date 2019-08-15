#!/bin/bash

# xset -b # disable bell

BAT_DISCH_STATUS="Discharging"

while true
do
	# VOL=$(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')
	LOCALTIME=$(date +%H:%M)

  BAT_STATUS=$(sudo tlp-stat -b | tail -n 11 | head -n 1 | awk '{print $3}')
  BAT_STATUS_FLAG=$([ $BAT_STATUS = $BAT_DISCH_STATUS ] && echo '' || echo '+')
  BAT=$(sudo tlp-stat -b | tail -n 6 | head -n 1 | awk '{print $3 "%"}')

  xsetroot -name "| $BAT_STATUS_FLAG $BAT | $LOCALTIME"
	sleep 20s
done &

exec dwm
