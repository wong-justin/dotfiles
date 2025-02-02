" updated for my Arch machine

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" Using a dark background within the editing area and syntax highlighting
set background=dark

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif



" MY CUSTOM CONFIG
" ================

" everything shown will be utf8
set encoding=utf-8

" everything written will be utf8
set fileencoding=utf-8

" show line numbers
set number relativenumber

" set backup, undo, and swap files location
" set directory=$HOME/Desktop/programming/_misc/vim_swap_files//
" set backupdir=$HOME/Desktop/programming/_misc/vim_swap_files//
set undodir=$HOME/Desktop/programming/_misc/vim_swap_files//

" actually i hate swap files now, too much hassle
set noswapfile

" make splits default to below instead of above
set splitbelow

" opens terminal in curr window
" assumes splitbelow=true
" command Term normal :term<CR><C-W>k:q!<CR><C-W>j
" EDIT - nvm, i never use embedded temrinals or vim windows anymore
"
" command! Term normal :term<CR><C-W>k:q!<CR>

" make vertical window split behave like horiz
" assumes vsplit goes right
" EDIT - nvm, i never use vim windows anymore
"
" nnoremap <C-W>v <C-W>v<C-W>l:enew<CR>
"" nnoremap <C-W><C-V> <C-W>v<C-W>l:enew<CR>

" save on every Esc
" although this can cause buggy behavior: https://stackoverflow.com/q/11940801
" inoremap <Esc> <Esc>:w<CR>
" nnoremap <Esc> <Esc>:w<CR>
" nnoremap <Esc>[ <Esc>[
" autocmd TermResponse * nnoremap <Esc> <Esc>:w<CR>
autocmd! InsertLeave * silent! update

" keep selection after indents
vnoremap < <gv
vnoremap > >gv

" initiate a search without affecting cursor position
" 1. silently fill search register
" 2. execute an empty %s search bc it shows statusbar output
"     (eg '3 results on 2 lines')
" 3. move cursor to begin the search
" " nnoremap / :let @/=''<Space><Bar><Space>%s///gn<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
" nnoremap / :let @/=''<Left>

" clear a search quickly to make highlights go away
"nnoremap ? :let @/=''<CR>
nnoremap <ESC> :let @/=''<CR>

" implied case sensitivity
set ignorecase
set smartcase

" auto make folds based on indentation
set foldmethod=indent
" but don't start files already folded
" set foldlevelstart=10
set nofoldenable
" and first folding shouldn't fold everything
set foldlevel=10

" set spacebar as special leader key
let mapleader = " "

" convenience for new empty buffer, like a scratchpad
nnoremap <leader>n :enew<CR>

" scroll with any vertical navigation
" set scrolloff=999

" tab thru buffers, personal fav buffer navigation method
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>

" naive f(ind) next occurrence motion
" nnoremap f :let @/=''<Space><Bar><Space>n<Bar>:let@/=''<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" i dont like highlighting matching parens
let loaded_matchparen = 1

" select-all shortcut
" nnoremap <C-A> ggvG

" shortcut for scrolling down/up
nnoremap <C-J> 9<C-E>
nnoremap <C-K> 9<C-Y>

" html filetype indentation
autocmd! FileType html setlocal shiftwidth=2 tabstop=2 expandtab
" convience to close html tags
autocmd! FileType html inoremap <buffer> </ </<C-X><C-O>
" i would for xml too, but it's not working...
" autocmd! FileType xml inoremap <buffer> </ </<C-X><C-O>

" javascript filetype indentation
autocmd! FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab

" xml filetype idnentation, at least for adndroid development
autocmd! FileType xml setlocal shiftwidth=2 tabstop=2 expandtab

" elm filetype indentation, converting tabs to spaces
" TODO: try setting up formatprg for autoformatting
autocmd! FileType elm setlocal shiftwidth=2 tabstop=2 expandtab
" autocmd! BufWrite *.elm ElmFormat " loses cursor
command! ElmFormat normal mm:%!elm-format --stdin --yes<CR>`m
autocmd! FileType elm nnoremap <leader>w :ElmFormat<CR>

" ocaml autoformatting
autocmd! FileType ocaml setlocal shiftwidth=2 tabstop=2 expandtab
command! OcamlFormat normal :%!ocamlformat %<CR>
autocmd! FileType ocaml nnoremap <leader>w :OcamlFormat<CR>
" prettify html in current buffer with <leader>w in normal mode
" EDIT - nvm, tidy compains too much and prints errors and doesnt like meta
" seciton and blah blah blah
" and EDIT - npx prettier doesnt do what i want either - i should just write
" my own
" command! HTMLFormat normal mm:%!npx prettier --stdin-filepath samplenamejustforextension.html<CR>`m
" autocmd! FileType html nnoremap <leader>w :HTMLFormat<CR>

" rust autoformatting
command! RustFormat normal mm:%!rustfmt --edition 2021<CR>`m
autocmd! FileType rust nnoremap <leader>w :RustFormat<CR>

" html autoformatting
command! HtmlFormat normal mm:%!superhtml fmt --stdin<CR>`m
autocmd! FileType html nnoremap <leader>w :HtmlFormat<CR>


" make .svelte like .html
au BufRead,BufNewFile *.svelte setfiletype html
" make xml... xml
au BufRead,BufNewFile *.xml setfiletype xml

" .json tab spacing
autocmd FileType json setlocal shiftwidth=2 tabstop=2 expandtab

" to get visual block mode using wsl on windows terminal
nnoremap <C-Q> <C-V>

" open url in browser (assuming url was just yanked to default register)
" command! Web normal :!~/personal_scripts/browse.sh '<C-R>"'<CR>
" test with: https://wonger.dev/clark/readme#:~:text=keep%20everything%20in%20the%20command%2Dline
" EDIT - nvm, `gx` over links will open automatically with non-windows vim 7.4+,
" at least when the cursor is before the anchor # fragment
"
" command! Web normal :!cmd.exe /C min '<C-R>"'<CR>
" nnoremap <leader>u :Web<CR>
" vnoremap <leader>u y:Web<CR>

" highlight search matches
set hlsearch

" presentation helper, highlight cursor line with <S-H>
func! HLCurrLine()
  let [_, lineno, _, _] = getpos(".")
    	
  " eg. '\%>0l\%<2l' matches first line
  let pattern = '\%>' . (lineno-1) . 'l\%<' . (lineno+1) . 'l'

  if exists("g:mirrored_cur_match_id")
    silent! call matchdelete(g:mirrored_cur_match_id)
  endif

  if !exists("g:last_line") || (g:last_line != lineno)
    silent! let g:mirrored_cur_match_id = matchadd('Search', pattern)
  endif
  let g:last_line = lineno
endfunc
nnoremap <S-H> :call HLCurrLine()<CR>

" turn off line numbers; useful for presenting
command! Nonum normal :set norelativenumber | set nonumber<CR>

" make default directional navigation work with line wraps
nnoremap k gk
nnoremap j gj

" HACKING TOGETHER A BOX DRAWING SHORTCUT
" draw a box at perimeter of visual block selection with <S-B>
func! DrawBoxAroundSelection()
  " assumes that first line len is max line len
  normal! gv"vy
  let lines = split(getreg('v'), '\n')
  let numlines = len(lines)
  let numcols = strdisplaywidth(lines[0])
  let line0 = '┌' . repeat('─', numcols-2) . '┐'
  let linen = '└' . repeat('─', numcols-2) . '┘'
  let updated_lines = [line0]
  for line in lines[1:-2]
    let boxed_line = '│' . strcharpart(line, 1, numcols-2) . '│'
    call add(updated_lines, boxed_line)
  endfor
  call add(updated_lines, linen)
  silent call setreg('v', updated_lines, "b" . numcols)
  silent normal! gv"vP
endfunc
vnoremap <S-B> :<C-U>call DrawBoxAroundSelection()<CR>

" remove gray status bar that appeared in nvim
" also remove the quieter statusline called ruler as well
set laststatus=0
set noruler

" increment letters like numbers with <C-a>
set nrformats+=alpha

" fix syntax highlighting breaking
autocmd BufEnter * syntax sync fromstart
nnoremap <leader>l <Esc>:syntax sync fromstart<CR>

" copy selection to windows clipboard (not utf-8 tho) (works in wsl too)
" EDIT - not on windows now
"
" vnoremap <S-C> :w !cmd.exe /C clip.exe<CR><CR>

" connect nvim to xclip keyboard
" :h clipboard
" it works differently (better) than normal vim
set clipboard+=unnamedplus
let g:clipboard = {
	\ 'name': 'xclip-clipboard-everywhere',
	\ 'copy': {
	\	'+': 'xclip -i -selection clipboard',
	\	'*': 'xclip -i -selection clipboard',
	\ },
	\ 'paste': {
	\	'+': 'xclip -o -selection clipboard',
	\	'*': 'xclip -o -selection clipboard',
	\ },
	\ 'cache_enabled': 0,
	\ }
" or connect nvim to windows system clipboard command
" let g:clipboard = {
" 	\ 'name': 'win32yank-wsl',
" 	\ 'copy': {
" 	\	'+': 'win32yank.exe -i --crlf',
" 	\	'*': 'win32yank.exe -i --crlf',
" 	\ },
" 	\ 'paste': {
" 	\	'+': 'win32yank.exe -o --lf',
" 	\	'*': 'win32yank.exe -o --lf',
" 	\ },
" 	\ 'cache_enabled': 0,
" 	\ }

" convenience for default registers == system clipboard
" vnoremap <leader>y "+y
" nnoremap <leader>y "+y
" 
" vnoremap <leader>p "+p
" nnoremap <leader>P "+P
" nnoremap <leader>p "+p


" alternative window controls since i've already bound ctrl-w for terminal/tmux
func! MoveToWindowBelow()
	let prev_window_id = winnr()
	wincmd j
	let curr_window_id = winnr()
	if (curr_window_id == prev_window_id)
		" wincmd j had no effect, so bubble up to tmux
		silent !tmux select-pane -D
		" get rid of annoying vim confirmation message
		normal <CR> 
	endif
endfunc
func! MoveToWindowAbove()
	let prev_window_id = winnr()
	wincmd k
	let curr_window_id = winnr()
	if (curr_window_id == prev_window_id)
		" wincmd j had no effect, so bubble up to tmux
		silent !tmux select-pane -U
		" get rid of annoying vim confirmation message
		normal <CR> 
	endif
endfunc
" nnoremap ├¬ :call MoveToWindowBelow()<CR>
nnoremap <leader>j :call MoveToWindowBelow()<CR>
nnoremap <leader>k :call MoveToWindowAbove()<CR>
" nnoremap <leader>j :winc j<CR>
" nnoremap <leader>k :winc k<CR>

" use terminal color palette
" apaprently using 16 terminal colors is already the default??
" and apparently i shouldnt have to set t_Co if my terminal is 
" correctly configured
" set t_Co=16
"
" EDIT - apparently truecolor is enabled by defeault, probs because ghostty
" sets $COLORTERM=truecolor
"
" to disable truecolor, and conseuqently enable default terminal theme colors,
" set notermguicolors



" PLUGINS
" =======
"
" call plug#begin('~/.vim/plugged')
" 
" Plug 'andys8/vim-elm-syntax'
" 
" call plug#end()







" HACKING TOGETHER AN ANSI ART EDITOR
" ===================================
" 
" func! MyHighlights()
" 	highlight YellowBlock ctermfg=9 ctermbg=9
" endfunc
" 
" func! AnsiLength(str)
" 	" get length of string after stripping ansi escape sequences.
" 	" this length is equivalent to desired col of rendered output,
" 	"   ie 'actual column'.
" 	" note: maybe a regex would be faster than a system call
" 	" note: ansifilter output length seems to include the escape sequence as a character, instead of desired grouping  with the following character
" 	silent return strlen( system('ansifilter', a:str) )
" endfunc
" 
" " note: for performance, consider preprocessing by making a csv of 
" "   source columns that correspond to each output column.
" "   would have to update it every time line(s) in source buffer is changed
" func! CalcRenderedAnsiLocation()
" 	" return lineno and col of rendered ansi art buffer,
" 	"   given cursor position in source buffer
" 	" eg:
" 	"
" 	" 'abc[1;2;3;mdef[4;5;6;m[7;8;9;mghi'
" 	"                                ^
" 	" 'abcdefghi'
" 	"        ^
" 	"
" 	" source col 28 -> rendered col 7
" 	" 13 -> 4
" 	" 4 -> 4
" 	" 1 -> 1
" 	
" 	let [_, lineno, col, _] = getpos(".")
" 	let source_line = getbufline(bufnr('%'), lineno)[0]
" 	
" 	" En = next escape char position/col in source line
" 	" Ep = prev ''
" 	" note: does not account for other escape codes, eg \e \033 \x1b
" 	"   consider converting escape codes in advance
" 	let En_col = stridx(source_line, '', col)
" 	let En_col = (En_col == -1 ? strlen(source_line) : En_col)
" 	let Ep_col = max([ strridx(source_line[0:col], '') , 0])
" 
" 	" position/col where esc seq is located in rendered output
" 	let En_rend_col = AnsiLength(source_line[0:En_col])
" 	let Ep_rend_col = AnsiLength(source_line[0:Ep_col])
" 
" 	" determining actual rendered column by comparing two methods
" 	let rend_col_far = En_rend_col - (En_col - col)
" 	let rend_col_near = Ep_rend_col
" 	let rend_col = max([rend_col_far, rend_col_near]) - 1
" 	return [lineno, rend_col]
" endfunc
" 
" " highlight position in current window
" func! HighlightLocation(linenum, colnum)
" 	" eg. '\%>0l\%<2l' matches first line
" 	let pattern_linematch = '\%>' . (a:linenum-1) . 'l\%<' . (a:linenum+1) . 'l'
" 	" eg. '\%5c.' matches char at 5th col
" 	let pattern_colmatch = '\%' . a:colnum . 'c.'
" 	let pattern = pattern_linematch . pattern_colmatch
" 
" 	" remove prev highlight and set current highlight
" 	if exists("g:mirrored_cur_match_id")
" 	  call matchdelete(g:mirrored_cur_match_id)
" 	endif
" 	let g:mirrored_cur_match_id = matchadd('YellowBlock', pattern)
" endfunc
" 
" " calculate desired position
" " highlight it in terminal window
" " assumes only/last window is terminal output render (and curr window is source file being edited) (ie winnr('$') == 2)
" func! HighlightCorrespondingAnsi()
" 	let [linenum, dest_col] = CalcRenderedAnsiLocation()
" 	let term_win_id = winnr('$')
" 	2 windo call HighlightLocation(linenum, dest_col)
" 	silent execute 'wincmd w'
" endfunc
" 
" " let g:cursor_highlight_on = 0
" " func! ToggleHighlight()
" " 	if g:cursor_highlight_on
" " 	  matchadd('YellowBlock', pattern)
" " endfunc
" 
" " Convenience controls for navigating between block chars
" " even better goal: nav to next character that's not in an escape sequence
" func! RemapCardinals()
" 	2 windo set nohlsearch
" 	let @/ = '[▄|▀|█]'
" 	" nnoremap <C-J> jn
" 	" nnoremap <C-K> kN
" 	" nnoremap <C-H> N
" 	" nnoremap <C-L> n
" endfunc
" 
" " for livereload: refreshing terminal buffer
" " tells other window (the one with term buffer) to load rendered ansi
" func! ReloadAnsi()
" 	let filename = expand('%')
" 	exec '2 windo term ++curwin cat ' . filename
" endfunc
" 
" " usage: :AnsiCursor<CR> when viewing a source file with ansi escapes
" " shows a corresponding rendered display in split window
" " missing: 
" " - livereload on change
" " consider :term ++curwin cat ... or :term ++hidden to not open a new window
" "
" " tips from developing:
" " - clearmatches() to get rid of orphaned match highlights
" " - use :2 windo ... to do commands on seemingly untouchable term window
" augroup CursorMirroring
"   autocmd! CursorMoved *.ansi if winnr('$') == 2 | call HighlightCorrespondingAnsi()
"   autocmd! InsertLeave *.ansi call ReloadAnsi()
"   " if buftype=terminal set nonumber norelativenumber
"   command! AnsiCursor normal :term cat %<CR>:call MyHighlights()<CR>:unlet! g:mirrored_cur_match_id<CR>:2 windo set nonumber norelativenumber<CR>
"   " :call RemapCardinals()<CR>
" augroup END
" 
" =========








" HACKING TOGETHER A DIRECTORY NAVIGATOR
" command! Cd normal y$:%!l -1 <C-R>"<CR>ggO..<CR>:cd <C-R>"<CR>


" HACKING A SIMPLENOTE UI WITH QUICKFIX LIST
"
" call setqflist([], ' ', {
" 	\ 'lines' : getqflist(),
" 	\ 'efm' : '%f',
" 	\ 'quickfixtextfunc': 'QfOldFiles',
" 	\ 'title': 'Search results: ' . getqflist({'title': 1}).title
" })
"
" call setqflist([], ' ', {'items': getqflist(), 'quickfixtextfunc': 'QfCustomGrepResult'}) | copen | <C-W> <S-K>
"
" func QfCustomGrepResult(info)
" 	" print name and grep match text, omitting default line and col num
" 	let items = getqflist({'id' : a:info.id, 'items' : 1}).items
" 	let l = []
" 	let seen = []
" 	for idx in range(a:info.start_idx - 1, a:info.end_idx - 1)
" 		let item = items[idx]
" 		let fname = bufname(item.bufnr)
" 		" if index(l:seen, l:fname) >= 0
" 		" 	continue
" 		" else
" 			call add(seen, fname)
" 			" consider adding spaces to make the result appear on
" 			" second line
" 			let displayed = printf('%s |  %s', fname, item.text)
" 			call add(l, displayed)
" 		" endif
" 	endfor
" 	return l
" endfunc
"
" autocmd QuickFixCmdPost * call setqflist([], ' ', {'items': getqflist(), 'quickfixtextfunc': 'QfCustomGrepResult'}) | copen | wincmd K
"
" nnoremap <expr> j &buftype ==# 'quickfix' ? ':cnext<CR><C-W>k' : 'j'
" nnoremap <expr> k &buftype ==# 'quickfix' ? ':cprev<CR><C-W>k' : 'k'





" MESSY CROSS-SESSION REGISTER SYNCING
" ---
" " alt-hjkl make windows terminal switch panes
" nnoremap ├¼ :!wt -w 0 mf right<CR><CR>
" nnoremap ├¿ :set lz<CR>:wv <Bar> call UpdateRegisters()<CR>:!wt -w 0 mf left<CR><CR>:set nolz<CR><CR>
" nnoremap ├½ :!wt -w 0 mf up<CR><CR>
" nnoremap ├¬ :wv <Bar> call UpdateRegisters()<CR>:!wt -w 0 mf down<CR><CR>
"
" " flag for each session to opt in to synced registers
" " let syncedSessions = "VIM"
" let @r="VIM,VIM1,VIM2"
"
" " update viminfo with this session's registers,
" " and tell other sessions to load that newly updated viminfo
" " nnoremap ├¡ :wv<CR>:!vim --server-name VIM --remote-send "<lt>Esc>:rv<lt>CR>"<CR><CR>
"
" function UpdateRegisters()
" 	let servers = split(@r, ',')
" 	" let servers = split(g:syncedSessions, ',')
" 	" let servers = split(system('vim --serverlist'), '\n')
" 	for s in servers
" 		let a = system('vim --servername ' . s . ' --remote-send "<Esc>:rv<CR>"')
" 	endfor
" endfunction

" used in ubuntu's default config/dotfiles forced upon me from wsl
" source $VIMRUNTIME/defaults.vim

" resolve utf-8 / cursor issue (??) with WSL
" https://superuser.com/a/553610
set t_RV=
" set ambw=double
" https://superuser.com/a/1525060
set t_u7=



