" Allows to copy current file name (relative to CWD)
" into default register and system clipboard at the same time
noremap <leader>fn :CopyCurrentFileName<cr>
command! CopyCurrentFileName call s:CopyCurrentFileName()

function! s:CopyCurrentFileName()
  let file_name = expand('%')
  " copy into vim's clipboard
  let @" = file_name
  " copy into system clipboard
  let @+ = file_name
endfunction
