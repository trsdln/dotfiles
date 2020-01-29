"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Setup Dirvish
" Sort folders at the top
let g:dirvish_mode = ':sort ,^.*[\/],'
let g:loaded_netrwPlugin = 1
" Keep legacy mappings in place
nnoremap <leader>t :vsplit \| edit .<cr>
nnoremap <leader>r :vsplit \| Dirvish %<cr>


" Set Solarized theme
let g:solarized_term_italics = 1

" set Vim-specific sequences for RGB colors
set termguicolors

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark
silent! colorscheme solarized8
" Fixes terminal window transparency for linux-gnu
if !has('macunix')
  hi Normal ctermbg=NONE guibg=NONE
endif

" Setup vim-javascript
let g:javascript_plugin_jsdoc = 1


" Setup vim-gutentags
let g:gutentags_modules = ['ctags']
let g:gutentags_auto_add_cscope = 1

" Index only files included into VCS repo
let g:gutentags_file_list_command = {
      \   'markers': {
      \     '.git': 'git ls-files',
      \   },
      \ }
let g:gutentags_resolve_symlinks = 0
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_ctags_exclude = [
      \ '*.yaml', '*.yml', '*.sh', '*.md', '*.lock', '*.css', '*.json',
      \ "e2e/src/data-samples/*",
      \ "packages/poly-react-scripts/*",
      \ "packages/poly-apollo-mocking/src/schema.js",
      \ "packages/secrets/*",
      \ "schema.json",
      \ "docs/*",
      \ ".dump/*",
      \ ".db/*"
      \ ]
let g:gutentags_ctags_exclude_wildignore = 1

augroup MyGutentagsStatusLineRefresher
  autocmd!
  autocmd User GutentagsUpdating call lightline#update()
  autocmd User GutentagsUpdated call lightline#update()
augroup END


" Setup ale
let g:ale_linters = { 'javascript': ['eslint'] }

let g:ale_fixers = {
      \   'javascript': ['prettier_eslint'],
      \   'json': ['prettier_eslint'],
      \ }

" Randomly breaks auto-import's 'go back to usage feature'
let g:ale_fix_on_save = 1
let g:ale_sign_error = "◉"
let g:ale_sign_warning = "◉"

highlight ALEErrorSign ctermfg=red ctermbg=black guifg=#D34A25
" guibg=#003641
highlight ALEWarningSign ctermfg=magenta ctermbg=black guifg=#6971C1
" guibg=#003641
" highlight SignColumn ctermbg=black guibg=#003641

" Configure Ale errors navigation
nmap <silent> [e <Plug>(ale_previous)
nmap <silent> ]e <Plug>(ale_next)
nmap <silent> [E <Plug>(ale_first)
nmap <silent> ]E <Plug>(ale_last)


" Configure spelunker.vim
let g:spelunker_max_hi_words_each_buf = 50
let g:spelunker_disable_auto_group = 1

function! s:SplunckerWrapper()
  let targetFile = expand('%:t')
  " allows ignore files with names that end with '.nospl.<any_ext>'
  if targetFile ==# 'schema.json' || targetFile =~? '\v\.nospl\.\w+$'
    return
  endif
  call spelunker#check()
endfunction

augroup spelunker
  autocmd!
  autocmd BufWinEnter,BufWritePost
        \ *.vim,*.js,*.jsx,*.json,*.sh,*.md,COMMIT_EDITMSG
        \ call s:SplunckerWrapper()
augroup END


" Configure easymotion
let g:EasyMotion_smartcase = 1


" Configure highlightedyank
let g:highlightedyank_highlight_duration = 300


" suda.vim configuration
command! SudoWrite write suda://%
command! -nargs=1 SudoEdit  edit  suda://<args>


" Configure vim-obsession
set sessionoptions=curdir,winpos,buffers,winsize,help,tabpages

" Start/Stop session tracking
nnoremap <leader>ss :Obsession<CR>

" Load default session
nnoremap <leader>so :source Session.vim<CR>


" Configure vim-dispatch
let g:dispatch_tmux_height = 0


" Configure js-file-import
let g:js_file_import_string_quote = "'"
