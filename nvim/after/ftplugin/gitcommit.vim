" Shortcut for [skip ci]
inoreabbrev <buffer> sci [skip ci]<C-R>=g:Eatchar('\s')<CR>

" Patches annoying bug with cursor initial
" position at 3rd line
" (reproduces randomly)
" augroup fix_commit_buffer_cursor_pos
"   autocmd!
"   autocmd BufEnter COMMIT_EDITMSG
"         \ if !exists('b:fix_cursor_position') |
"         \   let b:fix_cursor_position = 1 |
"         \   execute 'normal!gg' |
"         \ endif
" augroup END
