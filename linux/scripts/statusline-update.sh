#!/bin/sh

SCRIPTS_DIR=$(dirname "$0")
. $SCRIPTS_DIR/statusline/configs.sh

CYAN_COLOR="#2aa198"
YELLOW_COLOR="#b58900"
BLUE_COLOR="#268bd2"
RED_COLOR="#dc322f"
GREEN_COLOR="#859900"

lemonbar_update_info() {
  LOCAL_TIME="%{F$CYAN_COLOR}$(date '+%a %d %b %H:%M')%{F-}"
  # NY_TIME="$(TZ='America/New_York' date '+%a %H:%M')"

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

  if [ "${BAT_CAPACITY}" -lt "20" ]; then
    BATTERY_COLOR=$RED_COLOR
  elif [  "${BAT_CAPACITY}" -lt "50" ]; then
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

  # CPU temperature
  CPU_TEMP=$(sensors | awk '/Core 0/ {print gensub(/\+(.+)\..+/,"\\1","g",$3) }')
  if [ "${CPU_TEMP}" -lt "50" ]; then
    CPU_TEMP_COLOR=$BLUE_COLOR
  elif [ "${CPU_TEMP}" -lt "70" ]; then
    CPU_TEMP_COLOR=$YELLOW_COLOR
  else
    CPU_TEMP_COLOR=$RED_COLOR
  fi

  # Network status
  WIRED_NET_STATUS=$(cat /sys/class/net/e*/operstate)
  WIRELESS_NET_STATUS=$(cat /sys/class/net/w*/operstate)
  [ "${WIRED_NET_STATUS}" = 'down' -a "${WIRELESS_NET_STATUS}" = 'down' ] \
    && NETWORK_STATUS="🚫" || NETWORK_STATUS="🌐"

  # Keyboard layout
  KEYBOARD_LAYOUT="$(setxkbmap -query | awk '/layout/ {print toupper($2)}')"
  if [ $KEYBOARD_LAYOUT = "UA" ]; then
    KEYBOARD_LAYOUT_COLOR=$YELLOW_COLOR
  else
    KEYBOARD_LAYOUT_COLOR=$BLUE_COLOR
  fi

  WL_COUNT="📷:$(watch-later.sh count)"
  SEP="  "

  echo "C ${WL_COUNT}${SEP}${NETWORK_STATUS}${SEP}%{F$CPU_TEMP_COLOR}${CPU_TEMP}°C%{F-}${SEP}%{F$BATTERY_COLOR}${STATUS_ICON} ${BAT_CAPACITY}%%{F-}${SEP}%{F$KEYBOARD_LAYOUT_COLOR}${KEYBOARD_LAYOUT}%{F-}${SEP}${LOCAL_TIME}" > "${PANEL_FIFO}"
}

lemonbar_update_info
