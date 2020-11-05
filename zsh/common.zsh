export KEYTIMEOUT=1 # Reduce delay for vi mode at zsh
export SHELL='/bin/zsh'
export GPG_TTY=$(tty)
export LESSHISTFILE='-' # no history file for less
export NODE_REPL_HISTORY=''
export REACT_EDITOR='vim-session-open.sh'

source "${DOTFILES_PATH}/zsh/envs.sh"

# Load machine specific configs
if [ "${OSTYPE}" = "linux-gnu" ]; then
  source "${DOTFILES_PATH}/private/specific.linux.zsh"
else
  source "${DOTFILES_PATH}/private/specific.darwin.zsh"
  # fixes ctrl-O shortcut at neomutt
  # per https://github.com/neomutt/neomutt/issues/1195#issuecomment-388016804
  stty discard undef
fi

function android-screenshot {
  local file_name=~/Desktop/__android_screenshot.png
  rm -f ${file_name}
  adb shell screencap -p > ${file_name}
}

# Easy re-sourcing of config
alias reload='source ~/.zshrc'
alias vi='nvim'
alias tmux="tmux -f $HOME/.config/tmux.conf"

if [[ "$OSTYPE" == "darwin"* ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto -h'
fi

# Add common scripts
export PATH="${DOTFILES_PATH}/scripts:$PATH"

# Ensure apps installed by brew are resolved first
# (before system default) e.g. vim
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH="usr/local/bin:${DOTFILES_PATH}/darwin/scripts:$PATH"
fi

# Setup ripgrep
export RIPGREP_CONFIG_PATH="${DOTFILES_PATH}/.ripgreprc"

# Setup skim
# ---------
if [[ "$OSTYPE" == "darwin"* ]]; then
  if [[ ! "$PATH" == */usr/local/opt/skim/bin* ]]; then
    export PATH="$PATH:/usr/local/opt/skim/bin"
  fi
fi

# Auto-completion
if [[ $- == *i* ]]; then
  if [[ "$OSTYPE" == "darwin"* ]]; then
    source "/usr/local/opt/skim/shell/completion.zsh" 2> /dev/null
  else
    source "/usr/share/skim/completion.zsh" 2> /dev/null
  fi
fi

# Key bindings
if [[ "$OSTYPE" == "darwin"* ]]; then
  source "/usr/local/opt/skim/shell/key-bindings.zsh"
else
  . /usr/share/skim/key-bindings.zsh
fi

export SKIM_DEFAULT_COMMAND='rg --files'
export SKIM_CTRL_T_COMMAND=${SKIM_DEFAULT_COMMAND}

_gen_skim_default_opts() {
  local base02="235"
  local base2="254"
  local base3="230"
  local yellow="136"
  local blue="33"

  # Solarized Dark color scheme for skim
  export SKIM_DEFAULT_OPTIONS="
    --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue,info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
  "
}
_gen_skim_default_opts

export SKIM_CTRL_R_OPTS=''
# preview syntax highlighting theme
export BAT_THEME="Solarized (dark)"

# Setup lf
# ---------
# https://github.com/gokcehan/lf/blob/master/etc/lfcd.sh
lfcd () {
  tmp="$(mktemp)"
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    if [ -d "$dir" ]; then
      if [ "$dir" != "$(pwd)" ]; then
        cd "$dir"
      fi
    fi
  fi
}
bindkey -s '^o' 'lfcd\n'

source "$DOTFILES_PATH/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=blue'
# C-N to accept suggestion
bindkey '^N' autosuggest-accept

source "$DOTFILES_PATH/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

source "${DOTFILES_PATH}/zsh/plugins/yarn.completions.zsh"
