command! JSImportMembersSort g=\v^import\s?\{$=.+1,/\v^\}\s?from/ sort u | noh
command! -range JSImportLevelUp <line1>,<line2>s=\V'..\/='= | noh

set errorformat+=%f:\ line\ %l\\,\ col\ %c\\,\ %trror\ -\ %m
set errorformat+=%f:\ line\ %l\\,\ col\ %c\\,\ %tarning\ -\ %m

command! LintUnusedModules cexpr system('./scripts/lint-unused-modules-changed.sh')
