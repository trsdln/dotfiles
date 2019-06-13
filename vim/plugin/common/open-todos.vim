" Open file with TODOs using vsplit at left side
noremap <leader>td :ToggleTodosWofl<cr>
command ToggleTodosWofl call s:ToggleTodosWofl()

function! s:ToggleTodosWofl()
  let todos_file = 'todos.wofl'

  " Check if todo list is already visible
  if bufwinnr(todos_file) == -1
    " Show todos if not visible
    " Open using vsplit
    execute "vsplit | edit " . todos_file
    " Move to the far right
    execute "normal! \<C-W>L"
    " Increase width
    vertical resize 80

    if !filereadable(todos_file)
      echom "File '" . todos_file . "' does not exists! New one will be created."
    endif
  else
    " Hide todos if visible
    execute "bdelete " . todos_file
  endif
endfunction
