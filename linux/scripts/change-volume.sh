#!/bin/bash

VOLUME_VALUE=$1

SOURCE=$(amixer scontrols | cut -d "'" -f2 | head -n 1)

amixer sset "${SOURCE}" "${VOLUME_VALUE}"

VOLUME_STATUS=$(amixer get "${SOURCE}" | tail -n 1)
NEW_VOLUME_VALUE=$(echo $VOLUME_STATUS | awk -F'[][]' '{print $2 " " $4}')

notify-send --hint string:x-canonical-private-synchronous:volume \
  "Volume" "${NEW_VOLUME_VALUE}"
