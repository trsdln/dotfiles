#!/bin/bash

# Set keyboard layouts
setxkbmap -model thinkpad -layout us,ua -option grp:win_space_toggle

# load bindings
xbindkeys --poll-rc

# Set wallpaper
feh --bg-scale Pictures/wallpaper.jpg

BAT_DISCH_STATUS="Discharging"

while true
do
	LOCALTIME=$(date +%H:%M)

  TLP_RES=$(sudo tlp-stat -b | grep -E '(Charge\s+=|BAT0/status)')
  BAT_STATUS_FLAG=$([ $(echo $TLP_RES | awk '{print $3}') = $BAT_DISCH_STATUS ] && echo '' || echo '+')
  BAT=$(echo $TLP_RES  | awk '{print $6 "%"}')

  xsetroot -name "| $BAT_STATUS_FLAG $BAT | $LOCALTIME |"
	sleep 20s
done &

if [ "$(ps -u $USER | grep 'dunst' | wc -l)" -lt "1" ]; then
  dunst &
fi

exec dwm
