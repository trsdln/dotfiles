#!/bin/sh

youtube_dl_res=$(youtube-dl "${1}" --write-thumbnail --skip-download --output '/tmp/yt-thumbnail-%(id)s' | tail -n 1)
temp_thumbnail_file=${youtube_dl_res##* }

sxiv $temp_thumbnail_file &

sleep 10
rm -f $temp_thumbnail_file
