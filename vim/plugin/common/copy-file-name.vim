" Allows to copy current file name (realative to CWD)
" into default register and system clipboard at the same time
noremap <leader>fn :CopyCurrentFileName<cr>
command CopyCurrentFileName call s:CopyCurrentFileName()

function! s:CopyCurrentFileName()
  let file_name = expand('%')
  let @" = file_name
  " I need only Macos support for now
  silent call system('pbcopy', file_name)
endfunction
