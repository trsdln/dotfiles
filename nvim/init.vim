"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically install minpac
let s:minpac_opt_dir = $DOTFILES_PATH . '/nvim/pack/minpac/opt'
let s:minpac_install_dir = s:minpac_opt_dir . '/minpac'
" check any file at plugin dir
if empty(glob(s:minpac_install_dir . '/.gitignore'))
  silent execute '!mkdir -p ' . s:minpac_install_dir
  silent execute '!git clone https://github.com/k-takata/minpac.git' s:minpac_install_dir
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Load plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PackInit() abort
  packadd minpac

  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Better alternative to netrw/NERDTree
  call minpac#add('justinmk/vim-dirvish')

  " Faster CtrlP alternative
  call minpac#add('lotabout/skim')
  call minpac#add('lotabout/skim.vim')

  " Nice status bar at the bottom
  call minpac#add('itchyny/lightline.vim')

  " My favorite color scheme
  call minpac#add('lifepillar/vim-solarized8')

  " Best Git plugin for VIM
  call minpac#add('tpope/vim-fugitive')
  " Github links
  call minpac#add('tpope/vim-rhubarb')
  " Gitlab links
  call minpac#add('shumphrey/fugitive-gitlab.vim')
  " Bitbucket links
  call minpac#add('tommcdo/vim-fubitive')

  " Git log add-on for fugitive
  call minpac#add('junegunn/gv.vim')

  " Extension for Fugitive to manage branches
  call minpac#add('idanarye/vim-merginal')

  " Easy surround anything
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-commentary')
  " Better dot action support for surround and others
  call minpac#add('tpope/vim-repeat')
  " Shell commands shortcuts for Vim
  call minpac#add('tpope/vim-eunuch')
  " Linguistically correct substitution
  call minpac#add('tpope/vim-abolish', {'type': 'opt'})
  " Session management
  call minpac#add('tpope/vim-obsession')

  call minpac#add('tpope/vim-dispatch')

  call minpac#add('lambdalisue/suda.vim')

  " Automatic ctags generation
  call minpac#add('ludovicchabant/vim-gutentags')

  " Easy code navigation
  call minpac#add('easymotion/vim-easymotion')
  " Highlight unique characters while using F/f motions
  call minpac#add('unblevable/quick-scope')

  " Global search using Ripgrep
  call minpac#add('mhinz/vim-grepper')

  " Linting, especially by ESLint
  call minpac#add('dense-analysis/ale')

  " Workflowy analog for VIM
  call minpac#add('vim-scripts/workflowish')

  " Indentation aware pasting
  call minpac#add('sickill/vim-pasta')

  " Insert mode auto-completion for quotes, parens, brackets, etc.
  call minpac#add('Raimondi/delimitMate')

  " Highlight trailing whitespace
  call minpac#add('bronson/vim-trailing-whitespace')
  call minpac#add('nelstrom/vim-visual-star-search')

  " Multi-line like table text alignment
  call minpac#add('godlygeek/tabular', {'type': 'opt'})

  " Improved spell check for source code
  call minpac#add('kamykn/spelunker.vim')

  call minpac#add('machakann/vim-highlightedyank')

  call minpac#add('cespare/vim-toml')
  call minpac#add('kovetskiy/sxhkd-vim')

  call minpac#add('lifepillar/pgsql.vim')
  call minpac#add('trsdln/vim-javascript-sql')

  " JS Specific plugins
  call minpac#add('pangloss/vim-javascript')
  call minpac#add('MaxMEllon/vim-jsx-pretty')
  call minpac#add('alvan/vim-closetag')
  call minpac#add('jparise/vim-graphql')
  call minpac#add('hail2u/vim-css3-syntax')
  " Affects performance for bigger files, so it optional now
  call minpac#add('ap/vim-css-color', {'type': 'opt'})
  call minpac#add('styled-components/vim-styled-components', {'branch': 'main'})
  call minpac#add('kristijanhusak/vim-js-file-import', {'do': '!yarn install'})
endfunction

command! PackUpdate call PackInit() | call minpac#update('', {
      \ 'do': 'call minpac#status() | '
      \ . '!bash ' . $DOTFILES_PATH . '/scripts/common/vim-plugins-snapshot.sh'
      \ })
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
" List optional plugins
command! PackOptList echo "Note: packadd has auto-completion!"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin on

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
set wildignore+=*/tmp/*,*/node_modules/*,*/.meteor/local/*,*.so,*.swp,*.zip,*.ico,*.woff

" Do not show line number
set nonumber

" Do not show current position
set noruler

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

" Shortcut to rapidly toggle `set list`
nnoremap <leader>tl :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,trail:▢,eol:¬

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

" Scan current file for completion options
set complete+=i

" Hide annoying tabline if tabs aren't used
set showtabline=1
" Tabs mappings
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprevious<CR>
nnoremap tl  :tablast<CR>
nnoremap td  :tabclose<CR>
nnoremap tn  :tabnew<CR>
nnoremap tJ  :TabMoveLeft<CR>
nnoremap tK  :TabMoveRight<CR>

command! TabMoveLeft call s:tabMoveBy(-2)
command! TabMoveRight call s:tabMoveBy(1)

function! s:tabMoveBy(indexDiff)
  let nextTabIndex = tabpagenr() + a:indexDiff
  let lastTabIndex = tabpagenr('$')
  if nextTabIndex > lastTabIndex
    let nextTabIndex = 0
  elseif nextTabIndex < 0
    let nextTabIndex = lastTabIndex
  endif
  execute 'tabmove ' . nextTabIndex
endfunction

" Quicklist file entries navigation
nnoremap <silent> [f :cpfile<cr>
nnoremap <silent> ]f :cnfile<cr>
nnoremap <silent> [q :cprevious<cr>
nnoremap <silent> ]q :cnext<cr>

" Alt+J
nnoremap <silent> <M-j> :resize +1<CR>
" Alt+K
nnoremap <silent> <M-k> :resize -1<CR>
" Alt+L
nnoremap <silent> <M-l> :vertical resize +5<CR>
" Alt+H
nnoremap <silent> <M-h> :vertical resize -5<CR>

" Open last file at vsplit
nnoremap <silent> <leader>vt :execute "rightbelow vsplit " . bufname("#")<CR>
" Open last file at split
nnoremap <silent> <leader>hz :execute "rightbelow split " . bufname("#")<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use sane regexes
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Fix repeat last substitute (to keep flags)
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Remove search highlighting and redraw screen
noremap <silent> <leader>n :<c-u>nohlsearch<cr><C-l>

" Put search match at the center of screen
noremap n nzz
noremap N Nzz

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text Editing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add new line without entering insert mode
nnoremap oo o<Esc>k
nnoremap OO O<Esc>j

" UPPPERCASE_CONSTANTS_EASILY with Ctrl-U
inoremap <C-U> <Esc>viwUea
" Capitalize Word with Ctrl-K
inoremap <C-K> <Esc>b~ea

" Fast saving
nnoremap <leader>w :w!<cr>

if has('clipboard')
  nnoremap cp "+y
  vnoremap cp "+y
  nnoremap cP "+yy
  nnoremap cv "+p
  nnoremap cV "+P
endif

if has('nvim') || has('terminal')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Utility functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! g:ApplySnippetNavigationMapping()
  " Snippets guides. source:
  " https://github.com/LukeSmithxyz/voidrice/blob/archi3/.config/nvim/init.vim#L111
  inoremap <buffer> <C-]> <Esc>/<++><Enter>"_c4l
  vnoremap <buffer> <C-]> <Esc>/<++><Enter>"_c4l
  nnoremap <buffer> <C-]> <Esc>/<++><Enter>"_c4l
endfunction

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

" Quickly open dotfiles directory for edit at new tab
command! Dotfiles tabnew | lcd ~/.dotfiles | Dirvish

" try to get used to alternative mapping
nnoremap :wq :echo "use ZZ instead"<CR>

" configure ft_sql (default vim's plugin)
let g:sql_type_default = 'pgsql'
