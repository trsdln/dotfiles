try
  " Allow fzf file search while at dirvish buffer
  unmap <buffer> <C-p>
catch
endtry

" Create new file at current directory (with potentially new nested directories)
command! -nargs=1 E call s:CustomEdit(<f-args>)

function! s:CustomEdit(file_name)
  " Start file editing
  execute 'edit ' . a:file_name
  " Create potential parent directories
  Mkdir!
  " Save file itself
  write
endfunction

map <buffer> A :E %

nnoremap <buffer> xo :call g:XDGOpen(getline('.'))<cr>
