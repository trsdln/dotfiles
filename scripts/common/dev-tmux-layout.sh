#!/bin/bash

function tmux_session_exists {
  local session_name=$1
  tmux has-session -t ${session_name} 2>/dev/null
  echo $?
}


function smart_create_tmux_session {
  local session_name=$1
  local project_dir=$2
  local configure_session_cb=$3

  local session_exists=$(tmux_session_exists ${session_name})
  if [ "${session_exists}" -eq 1 ] ; then
    echo "Session '${session_name}' not found. Creating..."
    pushd ${project_dir}

    tmux new-session -d -s ${session_name}
    ${configure_session_cb} ${session_name}

    popd
  fi
}


function configure_severs_session {
  local session_name=$1

  # Apps window - PolyGraph, PolySite & PolyAdmin
  tmux new-window -t ${session_name}:2 -n "Apps"
  tmux split-window -h
  tmux select-pane -t 1
  tmux split-window -v

  tmux select-pane -t 0
  tmux send-keys "yarn start graph"

  tmux select-pane -t 1
  tmux send-keys "yarn start admin-new"

  tmux select-pane -t 2
  tmux send-keys "yarn start site"

  # Servers window - MongoDB; ElasticSearch; Redis
  tmux new-window -t ${session_name}:3 -n 'Servers'
  tmux split-window -h

  tmux select-pane -t 0
  tmux send-keys "./scripts/db/start-db.sh" ${EXEC_KEY}

  tmux select-pane -t 1
  tmux send-keys "elasticsearch" ${EXEC_KEY}

  tmux split-window -v
  tmux select-pane -t 2
  tmux send-keys "redis-server /usr/local/etc/redis.conf" ${EXEC_KEY}

  # Main window - 2 panes for on demand tasks
  tmux select-window -t ${session_name}:1
  tmux rename-window 'Main'
  tmux split-window -h
  tmux select-pane -t 0
  tmux send-keys "git fetch --prune && git pull" ${EXEC_KEY}
}

function configure_vim_session {
  local session_name=$1

  # Open Vim with project at first window
  tmux send-keys "vim ." ${EXEC_KEY}
  tmux rename-window "apps-vim"

  # Open wim with my configs at second window
  tmux new-window -t ${session_name}:2 -n 'dotfiles-vim'
  tmux send-keys "cd ${DOTFILES_PATH} && ${EDITOR} ." ${EXEC_KEY}

  # Finally go back to project Vim
  tmux select-window -t ${session_name}:1
}
