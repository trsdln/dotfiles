" In makrdown's header motion
onoremap <buffer> ih :<c-u>execute "normal! ?^\\(==\\+\\\\|--\\+\\)$\r:nohlsearch\rkvg_"<cr>
onoremap <buffer> ah :<c-u>execute "normal! ?^\\(==\\+\\\\|--\\+\\)$\r:nohlsearch\rVk"<cr>

call g:ApplySnippetNavigationMapping()

inoreabbrev <buffer> mdimg
      \ ![](<++>)<++>
      \<Esc>F[a
      \<C-R>=g:Eatchar('\s')<CR>

inoreabbrev <buffer> mdlink
      \ [](<++>)<++>
      \<Esc>F[a
      \<C-R>=g:Eatchar('\s')<CR>

setlocal textwidth=78
