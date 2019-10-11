vnoremap <leader>je :<c-u>JSRepl<cr>

command! JSRepl call s:JSRepl()

let s:js_repl_src_prefix = 'function maybeRequire (moduleName) { try { return require(moduleName); } catch(err) { console.error(moduleName,err.code); return null; } }'
  \ . 'const R = maybeRequire("ramda");'
  \ . 'const F = maybeRequire("fluture");'

let s:SED_SUB_EXP = shellescape('s/^/\/\/ /')

" Bug: fails at statements like `myFn('https://something.com')`
function! s:JSRepl()
  let input_src = s:GetVisualSelectionText()

  " Strip down comments to prevent mess up
  " of single line code
  let no_comments_src = substitute(input_src, '\v\/\/[^\n]+', '', 'g')

  let single_line_src = substitute(no_comments_src, '\n', ' ','g')

  let complete_src = s:js_repl_src_prefix . single_line_src

  let escaped_src = shellescape(complete_src)

  let eval_shell_cmd = "node -p " . escaped_src . " 2>&1 | sed " . s:SED_SUB_EXP

  " Go to the end of selection, so result
  " is inserted UNDER it for multiline code
  execute 'normal! gv`>'

  " Execute JS code
  execute 'read !' . eval_shell_cmd

  " Exit visual mode
  let exit_visual = mode() ==# 'v' ? 'v' : 'vv'
  execute 'normal! gv' . exit_visual
endfunction

" From https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
function! s:GetVisualSelectionText()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction
