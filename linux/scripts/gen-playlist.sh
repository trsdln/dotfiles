#!/bin/sh

playlist_name="$1.m3u"

for entry in $(ls $2); do
  echo "#EXTINF:, ${entry}" >> $playlist_name
  echo "$entry" >> $playlist_name
done
