#!/bin/sh

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
[ "${WIRED_NET_STATUS}" = 'down' -a "${WIRELESS_NET_STATUS}" = 'down' ] && NETWORK_STATUS="❎" || NETWORK_STATUS="🌐"


# Keyboard layout
KEYBOARD_LAYOUT="$(setxkbmap -query | awk '/layout/ {print toupper($2)}')"


# Weather
WEATHER_CACHE="$HOME/.local/share/weatherreport.cache"

getforecast() {
  rm -f "${WEATHER_CACHE}"
  local temp_weather_file="$(mktemp /tmp/weather_XXXXXXXXXX.txt)"

  ping -q -c 1 1.1.1.1 >/dev/null && curl -s "wttr.in" >> "${temp_weather_file}"

  local part1="$(sed '16q;d' "${temp_weather_file}" | grep -wo "[0-9]*%" | sort -n | sed -e '$!d' | sed -e "s/^/☔ /g" | tr -d '\n')"
  local part2="$(sed '13q;d' "${temp_weather_file}" | grep -o "m\\(-\\)*[0-9]\\+" | sort -n -t 'm' -k 2n | sed -e 1b -e '$!d' | tr '\n|m' ' ' | awk '{print " ❄️",$1 "°","🌞",$2 "°"}')"
  local new_report="${part1}${part2}"

  if [ "${new_report}" = "" ]; then
    local new_report="Error: empty report"
  fi

  echo "${new_report}" > "${WEATHER_CACHE}"
  rm -f "${temp_weather_file}"
}

if [ "$(stat -c %y ${WEATHER_CACHE} | awk '{print $1}')" != "$(date '+%Y-%m-%d')" ]
then
  getforecast
fi

if [ -f "${WEATHER_CACHE}" ]; then
  WEATHER="$(cat "${WEATHER_CACHE}" | tr -d '\n')"
else
  WEATHER="-"
fi

xsetroot -name " ${WEATHER} • ${NETWORK_STATUS} • ${CPU_TEMP} • ${STATUS_ICON} ${BAT_CAPACITY}% • ${KEYBOARD_LAYOUT} • ${LOCAL_TIME} ${NY_TIME}"
