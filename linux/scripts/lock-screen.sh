#!/bin/bash

# Provides fixed delay to give simple lockers a little bit of time to lock
# the screen before the system goes the sleep.
# Based on /usr/share/doc/xss-lock/transfer-sleep-lock-generic-delay.sh

## CONFIGURATION ##############################################################

# Command to start the locker (should not fork)
locker="slock"

# Delay in seconds. Note that by default systemd-logind allows a maximum sleep
# delay of 5 seconds.
sleep_delay=1

# Run before starting the locker
pre_lock() {
  # we need to change keyboard layout to correct one otherwise
  # there is no ability to change it while slock is running
  setxkbmap -model thinkpad -layout us
  return
}

# Run after the locker exits
post_lock() {
  # Set default monitor depending on what is plugged in
  toggle-screens.sh --fix
  # otherwise we get status line content of status line before lock/sleep
  # over next statusline refresh timeout
  statusline-update.sh
  return
}

###############################################################################

pre_lock

# kill locker if we get killed
trap 'kill %%' TERM INT

if [[ -e /dev/fd/${XSS_SLEEP_LOCK_FD:--1} ]]; then
  # lock fd is open, make sure the locker does not inherit a copy
  $locker {XSS_SLEEP_LOCK_FD}<&- &

  sleep $sleep_delay

  # now close our fd (only remaining copy) to indicate we're ready to sleep
  exec {XSS_SLEEP_LOCK_FD}<&-
else
  $locker &
fi

wait # for locker to exit

post_lock
