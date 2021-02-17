" Quick access mappings
noremap <leader>gs :Git<cr>
noremap <leader>gb :MerginalToggle<cr>

" Shortcut push to prevent hooks
call g:SetupCommandAlias("gpu","Git push --no-verify")

" Code review mappings
command! GitCodeReview :Git fetch --prune | Git difftool origin/develop | wincmd o | Gvdiffsplit origin/develop:%
command! GitCodeReviewPrevDiff :wincmd o | cpfile | Gvdiffsplit origin/develop:%
command! GitCodeReviewNextDiff :wincmd o | cnfile | Gvdiffsplit origin/develop:%
noremap [d :GitCodeReviewPrevDiff<cr>
noremap ]d :GitCodeReviewNextDiff<cr>
