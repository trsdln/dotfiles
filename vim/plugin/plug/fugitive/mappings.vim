" Quick access mappings
noremap <leader>gs :Gstatus<cr>

" Shortcut push to prevent hooks
call g:SetupCommandAlias("Gpu","Gpush --no-verify")
call g:SetupCommandAlias("gpu","Gpush --no-verify")
