" Based on https://github.com/christoomey/vim-tmux-runner/blob/master/plugin/vim-tmux-runner.vim
let s:runner_pane = 'servers:1.0'
let s:test_pane = 'servers:1.1'

let s:ctrl_c_sequence = ''

function! s:TargetedTmuxCommand(pane, command)
  return a:command . " -t " . a:pane
endfunction

function! s:JoinTmuxCommands(commands)
  return join(a:commands, ' \; ')
endfunction

function! s:Strip(string)
  return substitute(a:string, '^\s*\(.\{-}\)\s*\n\?$', '\1', '')
endfunction

function! s:SendTmuxCommand(command)
  let prefixed_command = "tmux " . a:command
  return s:Strip(system(prefixed_command))
endfunction

function! s:_SendKeys(pane, keys)
  let targeted_cmd = s:TargetedTmuxCommand(a:pane, "send-keys")
  let full_command = join([targeted_cmd, a:keys])
  call s:SendTmuxCommand(full_command)
endfunction

function! s:SendTmuxCopyModeExit(pane)
  if s:SendTmuxCommand("display-message -p -F '#{pane_in_mode}' -t " . a:pane)
    call s:_SendKeys(a:pane, "q")
  endif
endfunction

function! s:SendTextToRunner(pane, lines)
  let send_keys_cmd = s:TargetedTmuxCommand(a:pane, "send-keys")
  for line in a:lines
    let targeted_cmd = send_keys_cmd . ' ' . shellescape(line . "\r")
    call s:SendTmuxCommand(targeted_cmd)
  endfor
endfunction

function! s:FocusRunnerPane(pane)
  let command_arr = [
        \ s:TargetedTmuxCommand(a:pane, "select-window"),
        \ s:TargetedTmuxCommand(a:pane, "select-pane")
        \ ]

  let targeted_cmd = s:JoinTmuxCommands(l:command_arr)
  call s:SendTmuxCommand(targeted_cmd)
endfunction

function! s:SendLinesToRunner(pane) range
  call s:SendTmuxCopyModeExit(a:pane)
  call s:SendTextToRunner(a:pane, getline(a:firstline, a:lastline))
endfunction

function! s:SendCommandToRunner(pane, ...)
  call s:FocusRunnerPane(a:pane)
  call s:SendTmuxCopyModeExit(a:pane)
  let user_command = shellescape(a:1)
  call s:_SendKeys(a:pane, s:ctrl_c_sequence)
  call s:_SendKeys(a:pane, user_command)
  call s:_SendKeys(a:pane, "Enter")
endfunction

function! s:VtrScrollUp(pane)
  call s:FocusRunnerPane(a:pane)
  let scroll_cmd = s:TargetedTmuxCommand(a:pane, 'copy-mode -u')
  call s:SendTmuxCommand(scroll_cmd)
endfunction

command! -range VtrSendLinesToRunner <line1>,<line2>call s:SendLinesToRunner(s:runner_pane)
command! -nargs=? VtrSendCommandToRunner call s:SendCommandToRunner(s:test_pane, <f-args>)
command! VtrScrollUp call s:VtrScrollUp(s:test_pane)

nnoremap <leader>sl :VtrSendLinesToRunner<cr>
vnoremap <leader>sl :VtrSendLinesToRunner<cr>
nnoremap <leader>sf :%VtrSendLinesToRunner<cr>
nnoremap <leader>jj :VtrScrollUp<CR>
