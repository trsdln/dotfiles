" Based on https://github.com/christoomey/vim-tmux-runner/blob/master/plugin/vim-tmux-runner.vim
let s:runner_pane = 'servers:1.1'

let s:ctrl_c_sequence = ''

function! s:TargetedTmuxCommand(command)
  return a:command . " -t " . s:runner_pane
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

function! s:_SendKeys(keys)
  let targeted_cmd = s:TargetedTmuxCommand("send-keys")
  let full_command = join([targeted_cmd, a:keys])
  call s:SendTmuxCommand(full_command)
endfunction

function! s:SendTmuxCopyModeExit()
  if s:SendTmuxCommand("display-message -p -F '#{pane_in_mode}' -t " . s:runner_pane)
    call s:_SendKeys("q")
  endif
endfunction

function! s:SendTextToRunner(lines)
  let send_keys_cmd = s:TargetedTmuxCommand("send-keys")
  for line in a:lines
    let targeted_cmd = send_keys_cmd . ' ' . shellescape(line . "\r")
    call s:SendTmuxCommand(targeted_cmd)
  endfor
endfunction

function! s:FocusRunnerPane()
  let command_arr = [
        \ s:TargetedTmuxCommand("select-window"),
        \ s:TargetedTmuxCommand("select-pane")
        \ ]

  let targeted_cmd = s:JoinTmuxCommands(l:command_arr)
  call s:SendTmuxCommand(targeted_cmd)
endfunction

function! s:SendLinesToRunner() range
  call s:SendTmuxCopyModeExit()
  call s:SendTextToRunner(getline(a:firstline, a:lastline))
endfunction

function! s:SendCommandToRunner(...)
  call s:FocusRunnerPane()
  call s:SendTmuxCopyModeExit()
  let user_command = shellescape(a:1)
  call s:_SendKeys(s:ctrl_c_sequence)
  call s:_SendKeys(user_command)
  call s:_SendKeys("Enter")
endfunction

function! s:VtrScrollUp()
  call s:FocusRunnerPane()
  let scroll_cmd = s:TargetedTmuxCommand('copy-mode -u')
  call s:SendTmuxCommand(scroll_cmd)
endfunction

command! -range VtrSendLinesToRunner <line1>,<line2>call s:SendLinesToRunner()
command! -nargs=? VtrSendCommandToRunner call s:SendCommandToRunner(<f-args>)
command! VtrScrollUp call s:VtrScrollUp()

nnoremap <leader>sl :VtrSendLinesToRunner<cr>
vnoremap <leader>sl :VtrSendLinesToRunner<cr>
nnoremap <leader>jj :VtrScrollUp<CR>
