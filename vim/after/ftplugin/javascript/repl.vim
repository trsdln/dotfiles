vnoremap <leader>je :<c-u>JSRepl<cr>

command! JSRepl call s:JSRepl()

let s:js_repl_src_prefix = 'function maybeRequire (moduleName) { try { return require(moduleName); } catch(err) { console.error(moduleName,err.code); return null; } }'
  \ . 'const R = maybeRequire("ramda");'
  \ . 'const F = maybeRequire("fluture");'

let s:SED_SUB_EXP = shellescape('s/^/\/\/ /')

" To avoid escaping and comments edge cases
let s:temp_repl_file = tempname()

function! s:JSRepl()
  let input_src = s:GetVisualSelectionText()

  let complete_src = s:js_repl_src_prefix . input_src

  call writefile(split(complete_src, '\n'), s:temp_repl_file)

  let node_path = "NODE_PATH='" . getcwd() . "/node_modules'"

  let eval_shell_cmd = node_path . " node " . s:temp_repl_file . " 2>&1 | sed " . s:SED_SUB_EXP

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
