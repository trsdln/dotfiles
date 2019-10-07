#!/bin/sh

# Toggles eye rest notification service status

if [ $(systemctl --user is-active eye-rest.timer) = "active" ]; then
  NEW_STATUS="inactive"
  systemctl --user stop eye-rest.timer
else
  NEW_STATUS="active"
  systemctl --user start eye-rest.timer
fi

notify-send --hint string:x-canonical-private-synchronous:eye-rest-status \
  "Eye Rest" "${NEW_STATUS}"
