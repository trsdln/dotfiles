#!/bin/sh

notify-send --hint=string:x-canonical-private-synchronous:bluetooth-status \
  --icon=/usr/share/icons/Paper/32x32/devices/bluetooth.png \
  "Bluetooth" "Applying..."

# wait until status is toggled
sleep 5

bluetoothctl show > /dev/null
if [ "$?" = "0" ]; then
  bluetoothctl power on > /dev/null
  NEW_STATUS='Enabled'
else
  NEW_STATUS='Disabled'
fi

notify-send --hint=string:x-canonical-private-synchronous:bluetooth-status \
  --icon=/usr/share/icons/Paper/32x32/devices/bluetooth.png \
  "Bluetooth" "${NEW_STATUS}"
