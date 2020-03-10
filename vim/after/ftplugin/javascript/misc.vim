command! JSImportMembersSort g=\v^import\s?\{$=.+1,/\v^\}\s?from/ sort u | noh
command! -range JSImportLevelUp <line1>,<line2>s=\V'..\/='= | noh

command! LintDiff Dispatch -compiler=eslint ./scripts/lint-ci.sh origin/develop
command! -nargs=? Lint execute 'Dispatch -compiler=eslint ./node_modules/.bin/eslint -f compact ' . <q-args>

command! Jest compiler jest | Make -o
