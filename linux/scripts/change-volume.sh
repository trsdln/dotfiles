#!/bin/bash

VOLUME_VALUE=$1

amixer sset $(amixer scontrols | cut -d "'" -f2 | head -n 1) $VOLUME_VALUE

NEW_VOLUME_VALUE=$(amixer)

notify-send -h string:x-canonical-private-synchronous:volume "${NEW_VOLUME_VALUE}"
