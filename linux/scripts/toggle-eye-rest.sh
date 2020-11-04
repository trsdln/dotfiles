#!/bin/sh

# Toggles eye rest notification cron job

TMP_TABLE=$(mktemp /tmp/cron_XXXXXXXXXX.txt)
EYE_REST_ENTRY='*/15 * * * * $HOME/.dotfiles/linux/scripts/eye-rest-notify.sh'
crontab -l > $TMP_TABLE

grep 'eye-rest' $TMP_TABLE
HAS_JOB=$?

if [ "${HAS_JOB}" = 0 ]; then
  NEW_STATUS="inactive"
  crontab -r
else
  NEW_STATUS="active"
  echo "$EYE_REST_ENTRY" > $TMP_TABLE
  crontab $TMP_TABLE
fi

notify-send --hint string:x-canonical-private-synchronous:eye-rest-status \
  "Eye Rest" "${NEW_STATUS}"
