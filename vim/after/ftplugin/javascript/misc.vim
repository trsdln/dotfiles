command! SortJSImportMembers g=\v^import\s?\{$=.+1,/\v^\}\s?from/ sort u | noh

" Triggers ctags reindex for empty file before removal
" so obsolete definitions are removed from ctags
command! RemoveJS execute 'normal!ggdG' | write! | Delete
