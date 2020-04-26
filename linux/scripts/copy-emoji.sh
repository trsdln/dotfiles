#!/bin/sh

SCRIPTS_DIR=$(dirname "$0")

dmenu -i -p ">" -l 60 -fn "Hack:style=bold:antialias=true:size=20" < ${SCRIPTS_DIR}/../emoji.txt \
  | cut -d " " -f 1 \
  | tr -d '\n' \
  | xclip -selection clipboard
