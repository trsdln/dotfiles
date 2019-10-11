#!/bin/bash

# For debug mode (creates segregated sessions, nothing is executed)

if [ "${CONFIGS_DEBUG}" == "true" ]; then
  TMUX_SESSION_PREFIX="debug"
  EXEC_KEY=""
else
  # For ready to use mode
  TMUX_SESSION_PREFIX=""
  EXEC_KEY="C-m" # Submit shell command shortcut
fi

PROJECT_DIR=~/projects/poly/apps
VIM_SESSION="${TMUX_SESSION_PREFIX}vim"
SERVERS_SESSION="${TMUX_SESSION_PREFIX}servers"
