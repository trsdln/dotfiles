" Based on https://github.com/statico/vim-javascript-sql/blob/master/after/syntax/javascript/sql.vim

" modified only this first line:
exec 'syntax include @SQLSyntax syntax/' . g:sql_type_default . '.vim'

if exists('s:current_syntax')
  let b:current_syntax = s:current_syntax
endif

syntax region sqlTemplateString start=+`+ skip=+\\\(`\|$\)+ end=+`+ contains=@SQLSyntax,jsTemplateExpression,jsSpecial extend
exec 'syntax match sqlTaggedTemplate +\%(SQL\)\%(`\)\@=+ nextgroup=sqlTemplateString'

hi def link sqlTemplateString jsTemplateString
hi def link sqlTaggedTemplate jsTaggedTemplate

syn cluster jsExpression add=sqlTaggedTemplate
syn cluster sqlTaggedTemplate add=sqlTemplateString
