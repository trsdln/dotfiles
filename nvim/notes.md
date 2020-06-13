# Misc Notes

Small cheat sheet for various plugins and standard features.

## Tmux

* `C-b <space>`  - change layout
* `C-b ~`        - show previous messages from Tmux
* `C-b {`        - Swap the current pane with the previous pane.
* `C-b }`        - Swap the current pane with the next pane.
* `C-b C-o`      - Move panes around

### Text Selection

* `C-b [`    - selection/view mode

Then in selection mode:

* `<space>`  - start/reset selection
* `C-v`      - toggle between block/line selection modes

Note: most of vim's monitions work as well obviously

## Vanilla Vim

### Vim Terminal

* Mod-j - ZSH's vi-mode for command editing

### Window Shortcuts

* `C-W r`  - "rotate" split
* `C-W o`  - keep only current window at tab i.e. `:only`
* `C-W T`  - move window to new tab
* `C-W v`  - create vertical split
* `C-W s`  - create horizontal split
* `C-W c`  - close current window
* `C-W _`  - maximize height
* `C-W |`  - maximize width
* `C-W =`  - equalize widths and heights


### Buffer Navigation

* `C-o`  - move to previous position at jump list
* `C-i`  - move to next position at jump list
* `C-t`  - go to previous tag
* `gn`   - select current/next search match visually
* `gi`   - go to last change from insert mode and switch into it
* `g;`   - go previous item at change list
* `g,`   - go next item at change list
* `n`    - next search match
* `N`    - previous search match

### Misc

* `C-a`         - increase number under cursor
* `C-x`         - decrease number under cursor
* `z=`          - spell suggestion
* `zi`          - toggle fold (enable/disable)
* `zo`          - open fold
* `zc`          - close fold
* `zf{motion}`  - create a fold
* `gv`          - restore last visual mode selection
* `=`           - fix indentation
* `&`           - repeat last substitute command
* `g&`          - repeat last substitute with `%` range
* `@@`          - repeat last macros
* `@:`          - repeat last Ex command
* `q:`          - Ex command history
* `q/`/`q?`     - search history
* `g*`          - next partial matching word search
* `g#`          - previous partial matching word search
* `ZZ`          - save file and exit Vim
* `ZQ`          - exit Vim without saving file

### Switching into insert mode

Except common ones (`i/s/a/A/o/O`) there are couple more:

* `I` - insert at the start of line e.g. `0i`
* `S` - replace whole line e.g. `0Di`
* `C` - change to the end of line e.g. `Di`

### Motions

* `g0`, `g$`  - wrap wise versions of 0 and $
* `L`         - move cursor low relative to screen
* `H`         - move cursor high relative to screen
* `M`         - move cursor middle relative to screen
* `/`, `?`    - search; can be used with any operator!
* `` ` ` ``   - position before last jump
* `` `. ``    - position of last change
* `'.`        - line of last change
* `ge`, `gE`  - end of previous word/WORD
* `gn`        - next search match

### Insert/Command Mode Shortcuts

* `<C-H>`                 - delete last character
* `<C-W>`                 - delete word
* `<C-R>{register}`       - paste value from specified register characterwise
* `<C-R><C-P>{register}`  - paste value from specified register literally (no indentation)
* `<C-[>`                 - leave Insert mode e.g. `<Esc>`
* `<C-O>`                 - leave Insert mode for single key input and go back

### Visual Mode Shortcuts

* `o` - go to other end of selection

### Command Mode

* `:tabm #`       - move tab to #th position (starts from 0). If # is omitted tab is moved to last position by default.
* `:t {address}`  - move line to {address}
* `:c {address}`  - copy line to {address}
* `<C-R><C-W>`    - copy current word to command line
* `:norm!@a`      - when you need to apply a macro to many lines at once select lines with V and type to apply the macro to each selected line.
* `:argd *`       - clear arg list

### Registers

* `"`       - default register
* `_`       - "black-hole"
* `0`       - last yanked text
* `a`-`z`   - general purpose registers
* `/`       - last search pattern (useful for reusing with `:substitute` command)
* `.`       - last inserted text
* `:`       - last Ex command
* `%`, `#`  - current/alternative file name
* `+`       - system clipboard
* `=`       - VimScript expression register

#### Range addresses

* `.`            - current line
* `$`            - last line
* `1`            - first line
* `0`            - "virtual" line before first
* `%`            - whole file e.g. alias to `1,$`
* `addr1;addr2`  - addr2 is relative to addr1

#### Replace commands

* `:{range}s/{exp}/{str}/{flags}`           - make substitution
* `:{range}~{flags}` / `:{range}&r{flags}`  - repeat with last search pattern
* `:{range}&&{flags}`                       - repeat with new range and same flags

#### Global commands

* `:{range}global/{exp}/{command}` - apply command to each line that matches
  pattern
* `:{range}vglobal/{exp}/{command}` - apply command to each line that does
  not matches pattern

If command is complicated then `:g/{exp}/norm! @q` with prerecorded macros
will do the trick.

#### Replace Command Flags

* `&`  - flags from previous substitute (always goes first)
* `g`  - all matches at the line (without only first is replaced)
* `i`  - case insensitive
* `c`  - confirmation for each replacement
* `e`  - move cursor to the end of match
* `n`  - do not perform substitution just count matches

### Using column mode (like multi-cursor)

* Ctrl + V to go into column mode
* Select the columns and rows where you want to enter your text
* Shift + i to go into insert mode in column mode
* Type in the text you want to enter. Don't be discouraged by the fact that
  only the first row is changed.
* Esc to apply your change (or alternately Ctrl+c - to partially cancel changes)

### Quickfix/Location list

* `:cnext`/`:cprevious`  - switch to next previous file list
* `:cnfile`/`:cpfile`    - switch to next previous file list
* `:cc N`/`:ll N`        - go to Nth match
* `:cdo {cmd}`           - execute Ex command for each match
* `:cfdo {cmd}`          - execute Ex command for each file
* `:cwindow`             - open window
* `:colder`/`:cnewer`    - switch to older/newer Quickfix list
* `<CR>`                 - open current file from list at previous window

### Commands for viewing Vim's state

* `:ls`         - list of buffers
* `:args`       - list of arguments
* `:jumps`      - jump history
* `:changes`    - list of made changes
* `:marks`      - list of marks
* `:registers`  - list registers' contents

### Autocompletion shortcuts

* `C-y`     - accept current option
* `C-e`     - revert to initial text
* `C-l`     - add one character from current match
* `C-h`     - remove one character from current match
* `C-xC-o`  - omni-completion (context aware; available for JS/CSS/HTML)
* `C-nC-p`  - back to original with ability to filter options
* `C-xC-n`  - can by used to copy sequence of text somewhere at document if
  used sequentially multiple times


## VIM Plugins

### Fugitive

:Gread               - checkout file version from HEAD
:Gdiff               - 2 or 3way diff, depending on context
:diffget //2 or //3  - apply theirs/ours (at working copy buffer - middle one)

While previewing RO file `.` can be used to prepopulate full file path to
command line (useful for doing `:edit current_RO_file`).

### GV

Git log extension for vim-fugitive:

* `GV`  - open commit history (support `git log` options)
* `GV!` - open commit history for current file

### Gutentags

:GutentagsUpdate! - Rebuild tags for whole project

### Grepper

Syntax:

`Grepper -query [[{any RG args}...] --] {search pattern}`

Rg options:

* `-s`         - case sensitive;
* `-i`         - case insensitive;
* `-S`         - smart case by default;
* `-g {glob}`  - filter filenames by pattern.
* `-w`         - match words i.e. '\b{pattern}\b'

#### Find and replace at multiple files

After filling in Quickfix list with target files execute command:

```
cfdo %s/<search term>/<replace term>/cg
```

### Commentary

Commands:

* `gc{motion}`  - comment
* `gcc`         - uncomment

### Spelunker

* Zl - fix word under cursor
* ZL - fix all misspelling at file
* Zg - add word to spell file
* Zw - mark word as bad

### Abolish coercion

* `crc` - to `camelCase`
* `crm` - to `MixedCase`
* `cru` - to `CONSTANT_CASE`
* `crs` - to `snake_case`

### JS Auto Import

* `<leader>ig` - go to definition
* `<leader>is` - sort imports
* `<leader>ic` - clean imports
* `<leader>if` - clean imports

### FZF
* `C-x` - open at horizontal split
* `C-v` - open at vertical split
* `C-t` - open at new tab
