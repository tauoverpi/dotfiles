set nocompatible
set list
set ai
set cursorline
set autochdir
set backspace=eol,start,indent
set backupdir=~/.config/nvim/tmp/backup/
set conceallevel=2
set concealcursor=ni
set directory=~/.config/nvim/tmp/swap
set hlsearch!
set signcolumn=yes
set ignorecase
set incsearch
set lazyredraw
set lbr
set listchars=tab:\|\ ,eol:¬,extends:❯,precedes:❮,nbsp:▩
set magic
set mat=1
set mouse=a
set nohlsearch
set dg
set number
set scrolloff=5
set shiftwidth=2
set showmatch
set si
set smartcase
set smarttab
set t_Co=256
set tabstop=2
set tags=tags;
set textwidth=100
set noshowmode
set tw=500
set undodir=~/.config/nvim/tmp/undo/
set termguicolors
set relativenumber number
set undofile
set whichwrap+=<,>,h,l
set showtabline=2
set wrap
set laststatus=2
set foldlevelstart=99
set clipboard=unnamedplus

let g:theme = "light"

" blue 27303a
" gray f3f8fd
" black 1a2027
function! LightTheme()
	hi Comment      guifg=#bbbbbb gui=italic
	hi CursorLine   guifg=none guibg=#f3f8fd gui=none
	hi CursorLineNr guibg=#f3f8fd guifg=#1a2027 gui=none
	hi Delimiter    guifg=#111111
	hi Float        guifg=#888888 gui=none
	hi Number       guifg=#888888 gui=none
	hi Function     guifg=#111111
	hi Identifier   guifg=#111111
	hi Operator     guifg=#444444 gui=none
	hi String       guifg=#E1A126
	hi Include      guifg=#333333
	hi Statement    guifg=#D81735 gui=none
	hi Structure    guifg=#D81735 gui=none
	hi Type         guifg=#aaaaaa gui=none
	hi GitGutterAdd guibg=#27303a guifg=#eeeeee
	hi GitGutterChange guibg=#27303a guifg=#eeeeee
	hi GitGutterDelete guibg=#27303a guifg=#eeeeee
	hi Keyword                                  gui=none
	hi LineNr       guifg=#1a2027 guibg=#f3f8fd
	hi NonText      guifg=#e3e8ed guibg=#ffffff
	hi Normal       guifg=#1a2027 guibg=#FFFFFF
	hi Directory    guifg=#27303a
	hi Title        guifg=#1a2027
	hi Pmenu        guifg=#1a2027 guibg=#f3f8fd
	hi PmenuSel     guifg=#27303a guibg=#e3e8ed
	hi PreProc      guifg=#D81735 gui=none
	hi QuickFixLine guifg=#33373e
	hi SignColumn   guibg=#27303a guifg=#eeeeee
	hi StatusLine   guibg=#27303a guifg=#eeeeee gui=none
	hi StatusLineNC guibg=#27303a guifg=#eeeeee gui=none
	hi TabLine      guibg=#27303a guifg=#eeeeee gui=none
	hi TabLineFill  guibg=#27303a guifg=#eeeeee gui=none
	hi TabLineSel   guibg=#27303a guifg=#eeeeee gui=none
	hi VertSplit    guibg=#27303a guifg=#27303a gui=none
	hi Visual                     guibg=#eeeeee
	hi idrisMetaVar guifg=#FF5800 gui=underline
endfunction

function! DarkTheme()
	hi Comment      guifg=#33373e gui=italic
	hi CursorLine   guifg=none guibg=#080e0e gui=none
	hi CursorLineNr guifg=#33373e guibg=#00090
	hi Delimiter    guifg=#111111
	hi Float        guifg=#16B1FB
	hi Function     guifg=#2aa889
	hi GitGutterAdd guifg=#22262d guibg=#000909
	hi GitGutterChange guifg=#22262d guibg=#000900
	hi GitGutterDelete guifg=#22262d guibg=#000900
	hi Identifier   guifg=#111111
	hi Include      guifg=#97D01A
	hi Keyword                                  gui=none
	hi LineNr       guifg=#22262d guibg=#000909
	hi NonText      guifg=#000909
	hi Normal       guifg=#ABABAB guibg=#000909
	hi Number       guifg=#16B1FB
	hi Operator     guifg=#dddddd gui=none
	hi Pmenu        guifg=#33373e guibg=#000909
	hi PmenuSel     guifg=#000909 guibg=#222622
	hi PreProc      guifg=#D81735 gui=bold
	hi QuickFixLine guifg=#33373e
	hi SignColumn   guifg=#22262d guibg=#000909
	hi Statement    guifg=#D81735 gui=bold
	hi StatusLine   guifg=#22262d guibg=#000909 gui=none
	hi StatusLineNC guifg=#22262d guibg=#000909 gui=none
	hi String       guifg=#E1A126
	hi Structure    guifg=#D81735 gui=bold
	hi TabLine      guifg=#22262d guibg=#000909 gui=none
	hi TabLineFill  guifg=#22262d guibg=#000909 gui=none
	hi TabLineSel   guifg=#33373e guibg=#000909 gui=none
	hi VertSplit    guifg=#111317 guibg=#000909 gui=none
	hi Visual                     guibg=#111511
	hi idrisMetaVar guifg=#FF5800 gui=underline
endfunction

hi QuickFixLine guifg=#60ff60

let g:rainbow_active = 1
let g:rainbow_conf = {
\ 'guifgs': ['#d81735', '#97d01a', '#ffa800', '16b1fb', 'ff2491', '0fdcb6', '38252c', '76b639', 'e1a126', '289cd5', 'ff2491', '0a9b81']
\}

let g:limelight_conceal_ctermfg = '#33373e'
let g:limelight_conceal_guifg   = '#33373e'
let g:limelight_priority = 10

function! Tab_Or_Complete()
	if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
		return "\<C-x>\<C-o>"
	else
		return "\<Tab>"
	endif
endfunction

function! CleanFile()
	normal mZ
	:%s/\s\+$//e
	:%s/\n\{3,}/\r\r/e
	normal `Z
endfunction

function! s:goyo_enter()
	let b:quitting = 0
	let b:quitting_bang = 0
	autocmd QuitPre <buffer> let b:quitting = 1
	cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
	" Quit Vim if this is the only remaining buffer
	if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
		if b:quitting_bang
			qa!
		else
			qa
		endif
	endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

let g:toggle_goyo = 0
function! ToggleGoyo()
	if (g:toggle_goyo == 0)
		let g:toggle_goyo = 1
		Goyo 60%
	else
		let g:toggle_goyo = 0
		Goyo!
	endif
	if (g:theme == "dark")
		call DarkTheme()
	else
		call LightTheme()
	endif
endfunction

let g:toggle_lime = 0
function! ToggleLime()
	if (g:toggle_lime == 0)
		Limelight
		let g:toggle_lime = 1
	else
		let g:toggle_lime = 0
		Limelight!
	endif
endfunction
let g:paredit_shortmaps = 1

nm <F10> :AsyncRun mmc --infer-all % <CR>
nm <F7> :call ToggleLime()<CR>
nm <F8> :call ToggleGoyo()<CR>
nm <S-h> <C-w><
nm <S-j> <C-w>-
nm <S-k> <C-w>+
nm <S-l> <C-w>>
" PANE MOVEMENT
nm <Up> <C-w>k
nm <Left> <C-w>h
nm <Right> <C-w>l
nm <Down> <C-w>j
nm <Leader>= :exec ToggleCenterScreen(87)<CR>
" TAB MOVEMENT
nm <C-Left> :tabprevious<CR>
nm <C-Right> :tabnext<CR>

tno <Esc> <C-\><C-n>
tno <C-b><Esc> <Esc>

nm <C-t> :te<CR>
nm <C-n> :tabnew<CR>

ino <Tab> <C-R>=Tab_Or_Complete()<CR>
ino <Up> <NOP>
ino <Down> <NOP>
ino <Right> <NOP>
ino <Left> <NOP>

au BufNewFile,BufRead *.texi,*.idr,*.hs,*.scm,*.rkt,*.lhs,*.lidr,*.sats,*.ipkg,*.txt,*.m set expandtab
"whitespace
au BufNewFile,BufRead *.rkt hi error guibg=none
au BufWrite * call CleanFile()
au BufNewFile,BufRead *.lidr set filetype=idris | set filetype=lidris
au BufNewFile,BufRead *.scm,*.clj,*.lisp RainbowToggleOn
au BufEnter *.idr call Categories() | call ToggleLime()
au VimEnter * call LightTheme() | RainbowToggleOn
au VimEnter *.txt call ToggleGoyo()

let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'
let g:syntastic_style_error_symbol = '✠'
hi SyntasticErrorSign guibg=none ctermbg=none
hi SyntasticWarningSign guibg=none ctermbg=none
hi SyntasticStyleErrorSign guibg=none ctermbg=none
hi SyntasticStyleWarningSign guibg=none ctermbg=none
au BufNewFile,BufRead *.m set filetype=mercury
au BufWritePost *.m AsyncRun mmc -e -E -s tr --check-term --no-warn-stubs --allow-stubs --no-warn-nothing-exported --infer-all --no-warn-missing-module-name --use-subdirs %
