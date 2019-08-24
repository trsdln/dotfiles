#!/bin/bash

VOLUME_VALUE=$1

SOURCE=$(amixer scontrols | cut -d "'" -f2 | head -n 1)

amixer sset $SOURCE $VOLUME_VALUE

# NEW_VOLUME_VALUE=$(amixer)

notify-send -h string:x-canonical-private-synchronous:volume "Volume: ${VOLUME_VALUE}"
