#!/bin/sh

SCRIPTS_DIR=$(dirname "$0")
. $SCRIPTS_DIR/../configs.sh

# CPU temperature
CPU_TEMP=$(sensors | awk '/Core 0/ {print gensub(/\+(.+)\..+/,"\\1","g",$3) }')
if [ "${CPU_TEMP}" -lt "50" ]; then
  CPU_TEMP_COLOR=$BLUE_COLOR
elif [ "${CPU_TEMP}" -lt "70" ]; then
  CPU_TEMP_COLOR=$YELLOW_COLOR
else
  CPU_TEMP_COLOR=$RED_COLOR
fi

# refreshes itself on click
echo "U%{F$CPU_TEMP_COLOR}%{A:widg-act r cpu-temp:}$(wrap_self_edit "${CPU_TEMP}°C")%{A}%{F-}" > "${PANEL_FIFO}"
