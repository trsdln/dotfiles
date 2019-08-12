#!/bin/bash

APPS_DIR=${HOME}/apps
SUCKLESS_DIR=${APPS_DIR}/suckless
SUCKLESS_APPS=( \
  "dwm" \
  "st" \
  "dmenu" \
  )

if [ -d "$SUCKLESS_DIR" ]; then
  cd $SUCKLESS_DIR
else
  mkdir -p $SUCKLESS_DIR
  cd $SUCKLESS_DIR
  echo "Clonning apps..."
  for app_name in "${SUCKLESS_APPS[@]}"; do
    git clone git@github.com:trsdln/${app_name}.git
  done
fi

echo "Building apps..."
for app_name in "${SUCKLESS_APPS[@]}"; do
  cd $app_name
  make install
  cd ..
done
