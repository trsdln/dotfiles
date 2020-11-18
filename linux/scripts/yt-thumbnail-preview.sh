#!/bin/sh

thumbnail_url=$(youtube-dl --get-thumbnail "${1}")
thumbnail_name="${thumbnail_url##*/}"
thumbnail_name="${thumbnail_name%%\?*}"
temp_thumbnail_file=$(mktemp /tmp/yt_preview_XXXXXXXXXX_${thumbnail_name})

curl -o $temp_thumbnail_file "${thumbnail_url}"

sxiv $temp_thumbnail_file &

sleep 10
rm -f $temp_thumbnail_file
