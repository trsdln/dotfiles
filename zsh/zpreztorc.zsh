# Point Zprezto to configs directory
ZDOTDIR="${HOME}/.configs/zsh/zprezto"

# Source zprofile, because by default zprezto does it
source "${HOME}/.zprezto/runcoms/zprofile"

# Source Prezto
source "${HOME}/.zprezto/init.zsh"

[ -f ~/.configs/zsh/commonrc.zsh ] && source ~/.configs/zsh/commonrc.zsh

# C-<Space> to accept suggestion
bindkey '^ ' autosuggest-accept
