#!/bin/bash

# Set keyboard layouts
setxkbmap -model thinkpad -layout us,ua -option grp:win_space_toggle

# load bindings
xbindkeys --poll-rc

# Set wallpaper
feh --bg-scale Pictures/wallpaper.jpg

# xset -b # disable bell

BAT_DISCH_STATUS="Discharging"

while true
do
	# VOL=$(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')
	LOCALTIME=$(date +%H:%M)

  TLP_RES_MIN=$(sudo tlp-stat -b | cut -d"=" -f2 | tail -n 11 | head -n 6)
  BAT_STATUS_FLAG=$([ $(echo $TLP_RES_MIN | awk '{print $1}') = $BAT_DISCH_STATUS ] && echo '' || echo '+')
  BAT=$(echo $TLP_RES_MIN | awk '{print $6 "%"}')

  xsetroot -name "| $BAT_STATUS_FLAG $BAT | $LOCALTIME |"
	sleep 20s
done &

dunst &

exec dwm
