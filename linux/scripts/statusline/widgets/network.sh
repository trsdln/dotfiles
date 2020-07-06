#!/bin/sh

SCRIPTS_DIR=$(dirname "$0")
. $SCRIPTS_DIR/../configs.sh

WIRED_NET_STATUS=$(cat /sys/class/net/e*/operstate)
WIRELESS_NET_STATUS=$(cat /sys/class/net/w*/operstate)
[ "${WIRED_NET_STATUS}" = 'down' -a "${WIRELESS_NET_STATUS}" = 'down' ] \
  && NETWORK_STATUS="🚫" || NETWORK_STATUS="🌐"

echo "N$(wrap_self_edit "${NETWORK_STATUS}")" > "${PANEL_FIFO}"
