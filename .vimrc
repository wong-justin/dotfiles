" everything shown will be utf8
set encoding=utf-8

" everything file written will be utf8
set fileencoding=utf-8

" show line numbers
set number relativenumber

" set backup, undo, and swap files location
set directory=$HOME/Desktop/programming/_misc/vim_swap_files//
set backupdir=$HOME/Desktop/programming/_misc/vim_swap_files//
set undodir=$HOME/Desktop/programming/_misc/vim_swap_files//

" actually i hate swap files now, too much hassle
set noswapfile

" make splits default to below instead of above
set splitbelow

" opens terminal in curr window 
" assumes splitbelow=true
" command Term normal :term<CR><C-W>k:q!<CR><C-W>j
command Term normal :term<CR><C-W>k:q!<CR>

" make vertical window split behave like horiz
" assumes vsplit goes right
nnoremap <C-W>v <C-W>v<C-W>l:enew<CR>
" nnoremap <C-W><C-V> <C-W>v<C-W>l:enew<CR>

" save on every Esc
inoremap <Esc> <Esc>:w<CR>

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

" clear a search quickly
nnoremap ? :let @/=''<CR>

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

" convenience for new empty buffer
nnoremap <leader>n :enew<CR>

" scroll with any vertical navigation
set scrolloff=999

" tab thru buffers, personal fav buffer navigation method
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>

" copy selection to system clipboard (need a unicode-safe alternative
" to clip.exe tho)
vnoremap C :w !clip<CR><CR>

" naive f(ind) next occurrence motion
" nnoremap f :let @/=''<Space><Bar><Space>n<Bar>:let@/=''<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" i dont like highlighting matching parens
let loaded_matchparen = 1

" backwards end-of-word motion
nnoremap E ge

" select-all shortcut
nnoremap <C-A> ggvG

" shortcut for scrolling down/up
nnoremap <C-J> 9<C-E>
nnoremap <C-K> 9<C-Y>

" html filetype indentation
autocmd FileType html setlocal shiftwidth=2 tabstop=2






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
" nnoremap ì :!wt -w 0 mf right<CR><CR>
" nnoremap è :set lz<CR>:wv <Bar> call UpdateRegisters()<CR>:!wt -w 0 mf left<CR><CR>:set nolz<CR><CR>
" nnoremap ë :!wt -w 0 mf up<CR><CR>
" nnoremap ê :wv <Bar> call UpdateRegisters()<CR>:!wt -w 0 mf down<CR><CR>
" 
" " flag for each session to opt in to synced registers
" " let syncedSessions = "VIM"
" let @r="VIM,VIM1,VIM2"
" 
" " update viminfo with this session's registers,
" " and tell other sessions to load that newly updated viminfo
" " nnoremap í :wv<CR>:!vim --server-name VIM --remote-send "<lt>Esc>:rv<lt>CR>"<CR><CR>
" 
" function UpdateRegisters()
" 	let servers = split(@r, ',')
" 	" let servers = split(g:syncedSessions, ',')
" 	" let servers = split(system('vim --serverlist'), '\n')
" 	for s in servers
" 		let a = system('vim --servername ' . s . ' --remote-send "<Esc>:rv<CR>"')
" 	endfor
" endfunction




" DEFAULT, FROM EXAMPLE
" ---
" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

