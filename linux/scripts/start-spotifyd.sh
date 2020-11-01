#!/bin/sh

pgrep spotifyd
pgrep_res=$?
if [ "$pgrep_res" = 0 ]; then
  echo "Stopping old instance"
  killall spotifyd
fi

setsid nohup spotifyd --no-daemon > /dev/null &
