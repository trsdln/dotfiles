#!/bin/bash

# Provides simple history of plugin upgrades (in combination with VCS)
# for recovery back to stable version


function snapshots_main {
  # Figure out where this script is located
  local script_location_dir=$(cd $(dirname "$0") && pwd)

  local output_file=${script_location_dir}/vim-plugins-snapshot.log

  echo "Making snapshot file ${output_file}"

  if [ -e "${output_file}" ]; then
    echo "File exists. Removing old..."
    rm -f "${output_file}"
  else
    echo "File doesn't exist. Creating new..."
  fi

  touch "${output_file}"

  cd ~/.vim/bundle

  for plugin_dir in */ ; do
    local plugin_sha=$(cd ${plugin_dir} && git rev-parse --verify HEAD)
    echo "${plugin_dir}/${plugin_sha}" >> "${output_file}"
  done
}

snapshots_main
