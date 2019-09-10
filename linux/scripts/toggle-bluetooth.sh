#!/bin/dash

# Bluetooth button toggles "power on/off" automatically
# so script only shows current status

notify-send -h string:x-canonical-private-synchronous:bluetooth_status \
  "Bluetooth" "Applying..."

# wait until status is toggled
sleep 5

bluetoothctl show > /dev/null
if [ "$?" = "0" ]; then
  NEW_STATUS='Enabled'
else
  NEW_STATUS='Disabled'
fi

notify-send -h string:x-canonical-private-synchronous:bluetooth_status \
  "Bluetooth" "${NEW_STATUS}"
