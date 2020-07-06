#!/bin/sh

# button toggles wifi automatically so need just to show
# information message and update status line

notify-send --hint=string:x-canonical-private-synchronous:wifi-status \
  --icon=/usr/share/icons/Paper/32x32/devices/network-wireless.png \
  "WiFi" "applying..."

# wait until new settings are applied
sleep 10

notify-send --hint=string:x-canonical-private-synchronous:wifi-status \
  --icon=/usr/share/icons/Paper/32x32/devices/network-wireless.png \
  "WiFi" "$(sudo nmcli r wifi)"

SCRIPTS_DIR=$(dirname "$0")
$SCRIPTS_DIR/statusline/widgets/network.sh
