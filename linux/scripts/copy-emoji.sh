#!/bin/sh

SCRIPTS_DIR=$(dirname "$0")

dmenu -i -p ">" -l 60 < ${SCRIPTS_DIR}/../emoji.txt \
  | cut -d " " -f 1 \
  | tr -d '\n' \
  | xclip -selection clipboard
