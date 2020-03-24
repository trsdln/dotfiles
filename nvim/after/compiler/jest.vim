let current_compiler = "jest"

CompilerSet makeprg=CI=true\ JEST_UNIX_REPORTER=true\ ./node_modules/.bin/jest\ $*

CompilerSet errorformat=%f:%l:%c\ %m
