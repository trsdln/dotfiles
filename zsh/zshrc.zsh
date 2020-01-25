export DOTFILES_PATH="${HOME}/.dotfiles"

# ZSH specific configuration
source "${DOTFILES_PATH}/zsh/config.zsh"

source "${DOTFILES_PATH}/zsh/common.zsh"

if [ "$OSTYPE" = "linux-gnu" ]; then
  source "${DOTFILES_PATH}/zsh/linux.zsh"
fi


# Plugins (via Zplug)
export ZPLUG_HOME=$DOTFILES_PATH/zsh/zplug

# zplug initialization
[[ ! -f $ZPLUG_HOME/init.zsh ]] && git clone https://github.com/zplug/zplug $ZPLUG_HOME
source $ZPLUG_HOME/init.zsh

# ability update itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage', depth:1

zplug 'zsh-users/zsh-autosuggestions', as:plugin, use:"zsh-autosuggestions.zsh", depth:1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=blue'
# C-N to accept suggestion
bindkey '^N' autosuggest-accept

zplug "g-plane/zsh-yarn-autocompletions", hook-build:"./zplug.zsh", defer:2, depth:1

zplug 'zdharma/fast-syntax-highlighting', defer:2, hook-load:'FAST_HIGHLIGHT=()', depth:1

# finally install and load those plugins
zplug check || zplug install
zplug load
