#!/bin/sh

statusline_restart() {
  # pgrep is not able to find process if whole process
  # name is specified :facepalm:
  statusline_pid=$(pgrep 'statusline-star' | sort | head -n 1)

  if [ "${statusline_pid}" != "" ]; then
    pkill -P "${statusline_pid}"
  fi

  setsid statusline-start.sh 2>>$STATUSLINE_LOG &
}

# do not execute if script is sourced
[ "${0##*/}" = "statusline-restart.sh" ] && statusline_restart
