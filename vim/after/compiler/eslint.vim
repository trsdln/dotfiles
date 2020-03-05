let current_compiler = "eslint"

CompilerSet makeprg=./node_modules/.bin/eslint\ -f=compact\ $*

CompilerSet errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %trror\ -\ %m
CompilerSet errorformat+=%f:\ line\ %l\\,\ col\ %c\\,\ %tarning\ -\ %m
" remove line that contains amount of problems
CompilerSet errorformat+=%-G%*\\d\ problem%.%#
" remove lines that contain 0 or more whitespaces
CompilerSet errorformat+=%-G\\s%#
