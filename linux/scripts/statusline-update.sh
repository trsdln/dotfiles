#!/bin/bash

LOCALTIME=$(date +%H:%M%4a%_d-%b)

BAT_NAME="BAT0"
BAT_CAPACITY=$(cat "/sys/class/power_supply/$BAT_NAME/capacity")
BAT_STATUS=$(cat "/sys/class/power_supply/$BAT_NAME/status")

if [ "${BAT_CAPACITY}" -lt "15" ]; then
  notify-send --urgency=critical "Low Battery: ${BAT_CAPACITY}%"
fi

if [ $BAT_STATUS = 'Charging' ]; then
  STATUS_ICON='🔌'
fi

if [ $BAT_STATUS = 'Discharging' ]; then
  STATUS_ICON='🔋'
fi

if [ $BAT_STATUS = 'Not Charging' ]; then
  STATUS_ICON='🛑'
fi

if [ $BAT_STATUS = 'Unknown' ]; then
  STATUS_ICON='♻️'
fi

if [ $BAT_STATUS = 'Full' ]; then
  STATUS_ICON='⚡'
fi

CPU_TEMP=$(sensors | awk '/Core 0/ {print $3}')

xsetroot -name " ${CPU_TEMP} • ${STATUS_ICON} ${BAT_CAPACITY}% • ${LOCALTIME} "
