#!/bin/bash

# Executed before attach, but after session creation

function show_reminders {
  local remind_todos=$(cat ${CONFIGS_BIN_DIR}/../todos.wofl | grep '* \[remind\]')
  if [ $(echo "${remind_todos}" | wc -c) -gt 1 ]; then
    echo "======= REMINDERS ========"
    echo "${remind_todos}"
    echo "==== END OF REMINDERS ===="
    echo
    read -n 1 -s -r -p "Press any key to acknowledge"
    echo
  else
    echo "No uncompleted reminders"
  fi
}

show_reminders

# Check if Vim plugins are up to date
function check_vim_plugins {
  local utils_dir="${CONFIGS_BIN_DIR}/common"

  bash "${utils_dir}/vim-plugins-snapshot.sh"

  # check if snapshot was changed since last generation
  cd "${utils_dir}"
  git diff --quiet HEAD vim-plugins-snapshot.log
  local has_changes=$?

  if [ "${has_changes}" != "0" ]; then
    echo
    echo "=========== VIM Plugins status =============="
    echo "Warning: Some VIM plugins may be outdated."
    echo "============================================="
    echo
    read -n 1 -s -r -p "Press any key to acknowledge"
  fi
}

check_vim_plugins
