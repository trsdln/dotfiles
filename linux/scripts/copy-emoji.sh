#!/bin/sh

SCRIPTS_DIR=$(dirname "$0")

dmenu -i -p "Emoji>" -l 60 < ${SCRIPTS_DIR}/../emoji.txt | cut -d " " -f 1 | xclip -selection clipboard
