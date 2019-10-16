#!/bin/sh

VOLUME_VALUE=$1

SOURCE=$(amixer scontrols | cut -d "'" -f2 | head -n 1)

amixer sset "${SOURCE}" "${VOLUME_VALUE}"

VOLUME_INFO_LINE=$(amixer get "${SOURCE}" | tail -n 1)
NEW_VOLUME_VALUE=$(echo $VOLUME_INFO_LINE | awk -F'[][]' '{print $2 " " $4}')

VOLUME_STATUS=$(echo $VOLUME_INFO_LINE | awk -F'[][]' '{print $4}')
if [ "${VOLUME_STATUS}" = "off" ]; then
  ICON_NAME=audio-volume-muted.png
else
  ICON_NAME=audio-volume-medium.png
fi

notify-send --hint=string:x-canonical-private-synchronous:volume \
  --icon=/usr/share/icons/Paper/32x32/status/${ICON_NAME} \
  "Volume" "${NEW_VOLUME_VALUE}"
