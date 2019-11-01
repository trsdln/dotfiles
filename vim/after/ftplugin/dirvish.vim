try
  " Allow fzf file search while at dirvish buffer
  unmap <buffer> <C-p>
catch
endtry

" Create new file at current directory
map <buffer> A :e % \| w<left><left><left><left>
