#!/bin/bash

# sources: SERVERS_SESSION VIM_SESSION PROJECT_DIR EXEC_KEY
source ${CONFIGS_BIN_DIR}/common/dev-env-vars.sh

# source library of tmux related functions
source ${CONFIGS_BIN_DIR}/common/dev-tmux-layout.sh

VIM_SESSION_EXISTS=$(tmux_session_exists ${VIM_SESSION})

function dev_env_open_base {
  # Ensure both sessions exists
  smart_create_tmux_session ${SERVERS_SESSION} ${PROJECT_DIR} configure_severs_session
  smart_create_tmux_session ${VIM_SESSION} ${PROJECT_DIR} configure_vim_session

  # Smart session attach:
  # - on initialize connect to vim
  # - on second call connect to servers
  if [ "${VIM_SESSION_EXISTS}" -eq 1 ]; then
    # execute startup sequence on first call
    source ${CONFIGS_BIN_DIR}/common/dev-startup.sh

    tmux attach-session -t ${VIM_SESSION} &
  else
    tmux attach-session -t ${SERVERS_SESSION} &
  fi
}
