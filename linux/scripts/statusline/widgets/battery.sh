#!/bin/bash

SCRIPTS_DIR=$(dirname "$0")
. $SCRIPTS_DIR/../configs.sh

BAT_NAME="BAT0"
BAT_CAPACITY=$(cat "/sys/class/power_supply/$BAT_NAME/capacity")
BAT_STATUS=$(cat "/sys/class/power_supply/$BAT_NAME/status")

if [ "${BAT_CAPACITY}" -lt "15" ] && [ $BAT_STATUS != 'Charging' ]; then
  notify-send --urgency=critical \
    --icon=/usr/share/icons/Paper/32x32/status/battery-caution.png \
    --hint=string:x-canonical-private-synchronous:low-battery \
    "Low Charge" "Current Level: ${BAT_CAPACITY}%"
fi

if [ "${BAT_CAPACITY}" -lt "20" ]; then
  BATTERY_COLOR=$RED_COLOR
elif [ "${BAT_CAPACITY}" -lt "50" ]; then
  BATTERY_COLOR=$YELLOW_COLOR
else
  BATTERY_COLOR=$GREEN_COLOR
fi

if [ $BAT_STATUS = 'Charging' ]; then
  STATUS_ICON='⚡'
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
  STATUS_ICON='🔌'
fi

echo "B%{F$BATTERY_COLOR}%{A:$0:}$(wrap_self_edit "${STATUS_ICON} ${BAT_CAPACITY}%%")%{A}%{F-}" > "${PANEL_FIFO}"
