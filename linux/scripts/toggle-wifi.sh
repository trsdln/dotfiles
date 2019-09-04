#!/bin/dash

# button toggles wifi automatically so need just to show
# information message and update status line

notify-send -h string:x-canonical-private-synchronous:wifi_status \
  "WiFi" "applying..."

# wait until new settings are applied
sleep 10

notify-send -h string:x-canonical-private-synchronous:wifi_status \
  "WiFi" "$(sudo nmcli r wifi)"

. statusline-update.sh
