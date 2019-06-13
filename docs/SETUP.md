## Setup

1. Clone this repo
2. Link configs (if you already have configs, do unlink operation first)
3. Specify iTerm2 configuration path manually in preferences

Note: Don't move config repo. If you moved it then do steps 2 and 3 again.

### Linking

Links configs to `~` directory

```
./link.sh
```

### Unlinking

Removes configs from `~` directory

```
./link.sh unlink
```

## Zsh/VIM/TMUX setup

0. Zprezto setup

```sh
git clone --recursive git@github.com:trsdln/prezto.git "${HOME}/.zprezto"
```

1. Install Universal Ctags, Silver Searcher and Vim with python3 support

```
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install vim the_silver_searcher fzf
brew install tmux reattach-to-user-namespace tmux-mem-cpu-load
```

3. Ensure Brew's VIM/Ctags will be used at shell by putting `/usr/local/bin` before other directories at $PATH

```
# .zsh_specific
PATH="$(echo ~/.configs/bin):/usr/local/bin:$PATH"
```

4. Start vim and install plugins itself

```
:PlugInstall
```

5. Install prettier-eslint-cli globally to get vim-prettier working

```
yarn global add  prettier-eslint-cli
```

(ensure react ESlint correct version is installed `"eslint-plugin-react": "^7.12.3"` to prevent errors at stdout)
