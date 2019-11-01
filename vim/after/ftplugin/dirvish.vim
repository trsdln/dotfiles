try
  " Allow fzf file search while at dirvish buffer
  unmap <buffer> <C-p>
catch
endtry

" Create new file shortcut
map <buffer> A :e %
