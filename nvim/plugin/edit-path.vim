" Adds ability to edit file from path under cursor
noremap <leader>e :<c-u>EditFileFromCurrentPath ''<cr>
command! -nargs=? EditFileFromCurrentPath call s:EditFileFromCurrentPath(<args>)

function! s:SimplifyAndConcatPaths(path_head, path_tail)
  return simplify(a:path_head . '/' . a:path_tail)
endfunction

function! s:OpenFile(file_path, open_prefix)
  execute a:open_prefix
  execute "edit " . a:file_path
endfunction

function! s:EditFileFromCurrentPath(open_prefix)
  let position_str = matchstr(getline('.'), '\v\|\d+ col \d+\|')

  let raw_file_path = expand('<cfile>')
  let relative_to_cwd_path = s:SimplifyAndConcatPaths(getcwd(), raw_file_path)
  let relative_to_file_path = s:SimplifyAndConcatPaths(expand('%:p:h'), raw_file_path)

  " Simplest case
  if filereadable(relative_to_file_path)
    call s:OpenFile(relative_to_file_path, a:open_prefix)
  " JS Specific cases
  elseif filereadable(relative_to_file_path . '.js')
    call s:OpenFile(relative_to_file_path . '.js', a:open_prefix)
  elseif filereadable(relative_to_file_path . '/index.js')
    call s:OpenFile(relative_to_file_path . '/index.js', a:open_prefix)
  " Absolute path
  elseif filereadable(raw_file_path)
    call s:OpenFile(raw_file_path, a:open_prefix)
  " Relative to CWD
  elseif filereadable(relative_to_cwd_path)
    call s:OpenFile(relative_to_cwd_path, a:open_prefix)
  else
    echom "File '" . raw_file_path . "' not found!"
  endif

  " Go to specific position at file if specified (used at quicklist)
  if position_str !=# ''
    let line = matchstr(position_str, '\v\|\zs\d+\ze')
    let column = matchstr(position_str, '\vcol \zs\d+\ze\|')
    execute 'normal! ' . line . 'G' . column . '|'
  endif
endfunction
