command! -bang -nargs=* Rg call fzf#vim#rg_interactive(<q-args>, fzf#vim#with_preview('right:40%'))

" Search files
nnoremap <C-P> :Files<CR>

" Search mappings
nnoremap <leader>c :Maps<CR>

" Search ctags
nnoremap <leader>[ :Tags<CR>

let g:skim_layout = { 'down': '~40%' }

" Customize colors to match my color scheme
let g:skim_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Jump to the existing window if possible
let g:skim_buffers_jump = 1

" Enables skim to search tags
set tags+=.tags
