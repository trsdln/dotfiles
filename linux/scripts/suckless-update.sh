#!/bin/bash

SUCKLESS_DIR=$HOME/apps/suckless
SUCKLESS_APPS=( \
  "dwm" \
  "st" \
  "dmenu" \
  )

mkdir -p $SUCKLESS_DIR && cd $SUCKLESS_DIR

if [ -d "$SUCKLESS_DIR" ]; then
  for app_name in "${SUCKLESS_APPS[@]}"; do
    git clone git@github.com:trsdln/${app_name}.git
  done
fi

for app_name in "${SUCKLESS_APPS[@]}"; do
  cd $app_name
  make install
  cd ..
done

