#!/bin/bash

LOCALTIME=$(date +%H:%M%4a%_d-%b)

TLP_RES=$(sudo tlp-stat -b | grep -E '(Charge\s+=|BAT0/status)')
BAT_STATUS_FLAG=$([ $(echo $TLP_RES | awk '{print $3}') = $BAT_DISCH_STATUS ] && echo '' || echo '+')
BAT=$(echo $TLP_RES  | awk '{print $6 "%"}')

xsetroot -name " $BAT_STATUS_FLAG $BAT | $LOCALTIME "
