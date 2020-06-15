#!/bin/sh

temp_gif_name="/tmp/rain_$(date +%s).gif"
# todo: need caching here
curl -o $temp_gif_name 'https://api.sat24.com/animated/UK/rainTMC/3/GTB%20Standard%20Time/5482950'
sxiv -a $temp_gif_name
rm -f $temp_gif_name
