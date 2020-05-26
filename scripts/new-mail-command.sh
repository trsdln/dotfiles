#!/bin/bash

new_count=$1
unread_count=$2

# mutt executes it even for 0 new emails, so
# extra check should be done here to prevent
# obsolete notifications
if [ "${new_count}" -gt 0 ]; then
  if [ "$(uname -s)" = "Linux" ]; then
    notify-send --icon='/usr/share/icons/Paper/32x32/apps/email.png' \
      --hint='string:x-canonical-private-synchronous:mutt-new-email' \
      'New Email' "${new_count} new messages, ${unread_count} unread." &
  else
    echo "todo: implement for macos"
  fi
fi
