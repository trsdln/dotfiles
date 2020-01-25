# Setup autocompletion
autoload -Uz compinit
zmodload zsh/complist
compinit

setopt COMPLETE_ALIASES
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Change directory without cd
setopt autocd autopushd

# Set vim key bindings
bindkey -v


# Prompt
# source: https://github.com/sorin-ionescu/prezto/blob/master/modules/prompt/functions/prompt_sorin_setup
# Updates editor information when the keymap changes.
function editor-info() {
  if [[ "$KEYMAP" == 'vicmd' ]]; then
    _prompt_editor_info='%B%F{2}❮%F{3}❮%F{1}❮%f%b'
  else
    _prompt_editor_info='%B%F{1}❯%F{3}❯%F{2}❯%f%b'
  fi
}
zle -N editor-info
editor-info # initilalze info variable

function zle-keymap-select() {
  zle editor-info
  zle reset-prompt
  zle -R
}
zle -N zle-keymap-select

function zle-line-init {
  zle editor-info
  zle reset-prompt
  zle -R
}
zle -N zle-line-init

# prompt's PWD
autoload -Uz add-zsh-hook

function prompt-pwd() {
  setopt localoptions extendedglob

  local current_pwd="${PWD/#$HOME/~}"
  local ret_directory

  if [[ "$current_pwd" == (#m)[/~] ]]; then
    ret_directory="$MATCH"
    unset MATCH
  else
    ret_directory="${${${${(@j:/:M)${(@s:/:)current_pwd}##.#?}:h}%/}//\%/%%}/${${current_pwd:t}//\%/%%}"
  fi

  unset current_pwd

  print "$ret_directory"
}

function prompt_precmd() {
  _prompt_pwd=$(prompt-pwd)
  _prompt_git_branch="${$(command git symbolic-ref HEAD 2> /dev/null)#refs/heads/}"
}
add-zsh-hook precmd prompt_precmd

# enable expression evaluation at prompt
setopt prompt_subst
PROMPT='%F{blue}${_prompt_pwd}%f ${_prompt_editor_info} '
RPROMPT='%(?:: %F{1}✘%f) %F{2}${_prompt_git_branch}%f'


# History
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing non-existent history.

HISTFILE="${HOME}/.zhistory"    # The path to the history file.
HISTSIZE=10000                   # The maximum number of events to save in the internal history.
SAVEHIST=10000                   # The maximum number of events to save in the history file.


# Configure colors at less
export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.
