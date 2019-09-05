" Those match Dirvish mappings for consistency
" Open at horizontal split
nnoremap <buffer> <silent> o  <C-W><CR><C-W>J<C-W>p<C-W>J<C-W>p
" Open at horizontal split and close quick list
nnoremap <buffer> <silent> O  <C-W><CR><C-W>p<C-W>c<C-W>p
" Open at horizontal split and go back to quick list
nnoremap <buffer> <silent> go <C-W><CR><C-W>J<C-W>p<C-W>J
" Open at vertical split
nnoremap <buffer> <silent> a  <C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p
" Open at vertical split and close quick list
nnoremap <buffer> <silent> A  <C-W><CR><C-W>L<C-W>p<C-W>c<C-W>p
" Open at vertical split and go back to quick list
nnoremap <buffer> <silent> ga <C-W><CR><C-W>L<C-W>p<C-W>J
" Open at last visited window: <CR>
" Preview at last visited window
nnoremap <buffer> <silent> g<CR> <CR><C-W>p
