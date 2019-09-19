## Setup

1. Clone this repo into `~/.dotfiles`
2. Link configs
3. Specify iTerm2 configuration path manually in preferences

### Linking

Links all dot files to home directory

```
./configs-link
```

### Unlinking

Removes all dot files links

```
./configs-link unlink
```

## Zsh/VIM/TMUX setup

0. Zprezto setup

```sh
git clone --recursive git@github.com:trsdln/prezto.git "${HOME}/.zprezto"
```

1. Install Universal Ctags, Ripgrep and Vim with python3 support

```
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install vim ripgrep fzf
brew install tmux reattach-to-user-namespace tmux-mem-cpu-load osx-cpu-temp
```

3. Ensure Brew's VIM/Ctags will be used at shell by putting `/usr/local/bin` before other directories at $PATH

```
# .zsh_specific
PATH="/usr/local/bin:$PATH"
```

4. Start vim and install plugins itself

```
:PackUpdate
```

## Neovim

1. Python3 support:

```
pip3 install --user --upgrade pynvim
```
