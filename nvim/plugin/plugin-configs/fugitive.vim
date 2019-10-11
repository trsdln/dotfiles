" Quick access mappings
noremap <leader>gs :Gstatus<cr>
noremap <leader>gb :MerginalToggle<cr>

" Shortcut push to prevent hooks
call g:SetupCommandAlias("Gpu","Gpush --no-verify")
call g:SetupCommandAlias("gpu","Gpush --no-verify")

if has('nvim-0.3.2') || has("patch-8.1.0360")
    set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif
