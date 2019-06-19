"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

" Let vim-plug  manage plugins
call plug#begin('~/.vim/bundle')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Load plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Better alternative to netrw/NERDTree
Plug 'justinmk/vim-dirvish'

" Faster CtrlP alternative
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Nice status bar at the bottom
Plug 'itchyny/lightline.vim'
" My favorite color scheme
Plug 'lifepillar/vim-solarized8'

" Best Git plugin for VIM
Plug 'tpope/vim-fugitive'
" Git log add-on for fugitive
Plug 'junegunn/gv.vim'

" Easy surround anything
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" Better dot action support for surround and others
Plug 'tpope/vim-repeat'
" Shell commands shortcuts for Vim
Plug 'tpope/vim-eunuch'
" Linguistically correct substitution
Plug 'tpope/vim-abolish'

" Automatic ctags generation
Plug 'ludovicchabant/vim-gutentags'
" Easy code navigation
Plug 'easymotion/vim-easymotion'

" System Clipboard Support
if has('clipboard')
  nnoremap cp "+y
  vnoremap cp "+y
  nnoremap cP "+yy
  nnoremap cv "+p
  nnoremap cV "+P
else
  Plug 'christoomey/vim-system-copy'
endif

" Global search using Silver Searcher
Plug 'mileszs/ack.vim'

" Linting, especially by ESLint
Plug 'w0rp/ale'

" Workflowy analog for VIM
Plug 'vim-scripts/workflowish'

" Indentation aware pasting
Plug 'sickill/vim-pasta'

" Insert mode auto-completion for quotes, parens, brackets, etc.
Plug 'Raimondi/delimitMate'

" Highlight trailing whitespace
Plug 'bronson/vim-trailing-whitespace'


" JS Specific plugins
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'jparise/vim-graphql'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'styled-components/vim-styled-components', {'branch': 'main'}
Plug 'trsdln/vim-js-file-import', {'do': 'npm install'}
Plug 'heavenshell/vim-prettier'

" Multi-line like table text alignment
" (Note: should go after JS specific plugins otherwise breaks vim-prettier)
Plug 'godlygeek/tabular'

" Improved spell check for source code
Plug 'kamykn/spelunker.vim'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Set to auto read when a file is changed from the outside
set autoread

" Set <Leader>
let mapleader = ","
" retain backward character search as \
noremap \ ,

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" Turn on the WiLd menu
set wildmenu
" Match Zsh behaviour while auto-completing
set wildmode=full

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set wildignore+=*/tmp/*,*/node_modules/*,*/.meteor/local/*,*.so,*.swp,*.zip,*.png,*.ico,*.woff

" Show line number
set number

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=

" Eliminate delay after <esc>
set timeoutlen=500 ttimeoutlen=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Highlight the current line in the current window.
augroup cursorline
    autocmd!
    autocmd BufEnter * set cursorline
    autocmd BufLeave * set nocursorline
    autocmd InsertEnter * set nocursorline
    autocmd InsertLeave * set cursorline
augroup end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Treat 2 spaces as single tab character while removing
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set linebreak
set textwidth=500

set autoindent  " Auto indent
set si          " Smart indent
set wrap        " Wrap lines

" Hide annoying tabline if tabs aren't used
set showtabline=1
" Tabs mappings
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprevious<CR>
nnoremap tl  :tablast<CR>
nnoremap td  :tabclose<CR>
nnoremap tn  :tabnew<CR>
" Move tabs (naive implementation: no edge case support)
nnoremap tJ  :execute 'tabm ' . (tabpagenr() - 2)<CR>
nnoremap tK  :execute 'tabm ' . (tabpagenr() + 1)<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Split window appears below the current one.
set splitbelow

" Split window appears right the current one.
set splitright

" Treat long lines as break lines (useful when moving around in them)
noremap j gj
noremap k gk
noremap gj j
noremap gk k
" Adjust edge motions as well
noremap 0 g0
noremap $ g$
noremap g0 0
noremap g$ $

" Smart way to move between windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Close the current buffer
noremap <leader>q :bdelete<cr>

" Close all the buffers
noremap <leader>ba :bufdo bd<cr>

" Move between buffers
noremap <leader>l :bnext<cr>
noremap <leader>h :bprevious<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Remap first non-blank character
noremap 0 ^

" Use sane regexes
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Fix repeat last substitute (to keep flags)
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Remove search highlighting and redraw screen
noremap <leader>n :<c-u>nohlsearch<cr><C-l>

" Put search match at the center of screen
noremap n nzz
noremap N Nzz

" Fast saving
nnoremap <leader>w :w!<cr>

" Add new line without entering insert mode
nnoremap oo o<Esc>k
nnoremap OO O<Esc>j

" Better window resizing
nnoremap <Leader>hi :resize +5<CR>
nnoremap <Leader>hd :resize -5<CR>
nnoremap <Leader>vi :vertical resize +10<CR>
nnoremap <Leader>vd :vertical resize -10<CR>

" Open last file at vsplit
nnoremap <leader>vt :execute "rightbelow vsplit " . bufname("#")<CR>
" Open last file at split
nnoremap <leader>hz :execute "rightbelow split " . bufname("#")<CR>

" Shortcut to rapidly toggle `set list`
nnoremap <leader>tl :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,trail:▢,eol:¬

" UPPPERCASE_CONSTANTS_EASILY with Ctrl-U
inoremap <C-U> <Esc>viwUea
" Capitalize Word with Ctrl-K
inoremap <C-K> <Esc>b~ea


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Utility functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Very useful for abbreviation's trailing space removal:
" <C-R>=g:Eatchar('\s')<CR>
function! g:Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunction

" Prevents command aliases from expansion
" in the middle of another command
function! g:SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction
