#!/bin/sh

# otherwise we get status line content of status line before lock/sleep
# over next statusline refresh timeout
statusline-update.sh

# we need to change keyboard layout to correct one otherwise
# there is no ability to change it while slock is running
setxkbmap -model thinkpad -layout us

slock
