# Reduce delay for vi mode at zsh
export KEYTIMEOUT=1

export EDITOR='nvim'
export VISUAL='nvim'
export SHELL='/bin/zsh'

# Load machine specific configs
[ -f ~/.zsh_specific ] && source ~/.zsh_specific

function android-screenshot {
  local file_name=~/Desktop/__android_screenshot.png
  rm -f ${file_name}
  adb shell screencap -p > ${file_name}
}

# Easy re-sourcing of config
alias reload='source ~/.zshrc'
alias vi='nvim'

if [[ "$OSTYPE" == "darwin"* ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
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

# Setup fzf
# ---------
if [[ "$OSTYPE" == "darwin"* ]]; then
  if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
    export PATH="$PATH:/usr/local/opt/fzf/bin"
  fi
fi

# Auto-completion
if [[ $- == *i* ]]; then
  if [[ "$OSTYPE" == "darwin"* ]]; then
    source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
  else
    source "/usr/share/fzf/completion.zsh" 2> /dev/null
  fi
fi

# Key bindings
if [[ "$OSTYPE" == "darwin"* ]]; then
  source "/usr/local/opt/fzf/shell/key-bindings.zsh"
else
  source "/usr/share/fzf/key-bindings.zsh"
fi

export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}

_gen_fzf_default_opts() {
  local base03="234"
  local base02="235"
  local base01="240"
  local base00="241"
  local base0="244"
  local base1="245"
  local base2="254"
  local base3="230"
  local yellow="136"
  local orange="166"
  local red="160"
  local magenta="125"
  local violet="61"
  local blue="33"
  local cyan="37"
  local green="64"

  # Solarized Dark color scheme for fzf
  export FZF_DEFAULT_OPTS="
    --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
    --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
  "
}
_gen_fzf_default_opts

export FZF_CTRL_R_OPTS='--sort'

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
