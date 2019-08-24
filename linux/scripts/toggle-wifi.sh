#!/bin/bash

# button toggles wifi automatically so need just to show
# information message
notify-send -h string:x-canonical-private-synchronous:wifi_status \
  "WiFi: $(sudo nmcli r wifi)"
