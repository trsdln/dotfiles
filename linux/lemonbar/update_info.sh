#!/bin/sh

LEMONBAR_DIR=$(dirname "$0")
. $LEMONBAR_DIR/configs.sh

lemonbar_update_info() {
  LOCAL_TIME=$(date '+%a %d %b %H:%M')
  NY_TIME="" # "• $(TZ='America/New_York' date '+%a %H:%M')"


  # Battery status
  BAT_NAME="BAT0"
  BAT_CAPACITY=$(cat "/sys/class/power_supply/$BAT_NAME/capacity")
  BAT_STATUS=$(cat "/sys/class/power_supply/$BAT_NAME/status")

  if [ "${BAT_CAPACITY}" -lt "15" ] && [ $BAT_STATUS != 'Charging' ]; then
    notify-send --urgency=critical \
      --icon=/usr/share/icons/Paper/32x32/status/battery-caution.png \
      --hint=string:x-canonical-private-synchronous:low-battery \
      "Low Charge" "Current Level: ${BAT_CAPACITY}%"
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


  # CPU temperature
  CPU_TEMP=$(sensors | awk '/Core 0/ {print $3}')


  # Network status
  WIRED_NET_STATUS=$(cat /sys/class/net/e*/operstate)
  WIRELESS_NET_STATUS=$(cat /sys/class/net/w*/operstate)
  [ "${WIRED_NET_STATUS}" = 'down' -a "${WIRELESS_NET_STATUS}" = 'down' ] && NETWORK_STATUS="x" || NETWORK_STATUS="I"


  # Keyboard layout
  KEYBOARD_LAYOUT="$(setxkbmap -query | awk '/layout/ {print toupper($2)}')"

  WL_COUNT="WL:$(watch-later.sh count)"

  echo "C ${WL_COUNT} • ${NETWORK_STATUS} • ${CPU_TEMP} • ${STATUS_ICON} ${BAT_CAPACITY}% • ${KEYBOARD_LAYOUT} • ${LOCAL_TIME} ${NY_TIME}" > "${PANEL_FIFO}"
}

if [ "$1" = "--now" ]; then
  lemonbar_update_info
fi
