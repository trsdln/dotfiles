#!/bin/sh

notify-send -h string:x-canonical-private-synchronous:bluetooth_status \
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

notify-send -h string:x-canonical-private-synchronous:bluetooth_status \
  "Bluetooth" "${NEW_STATUS}"
