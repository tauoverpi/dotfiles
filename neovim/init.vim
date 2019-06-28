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
" set listchars=tab:\|\ ,eol:¬,extends:❯,precedes:❮,nbsp:▩
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
" set colorcolumn=64
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

let g:theme = "dark"

" blue 27303a
" gray f3f8fd
" black 1a2027
function! LightTheme()
	hi Comment      guifg=#bbbbbb gui=italic
	hi CursorLine   guifg=none guibg=#f3f8fd gui=none
	hi CursorLineNr guibg=#f3f8fd guifg=#aaaaaa gui=none
	hi Delimiter    guifg=#111111
	hi Float        guifg=#444444 gui=none
	hi Number       guifg=#444444 gui=none
	hi Function     guifg=#111111
	hi Identifier   guifg=#111111
	hi Operator     guifg=#444444 gui=none
	hi String       guifg=#E1A126
	hi Include      guifg=#333333
	hi Statement    guifg=#222222 gui=none
	hi Structure    guifg=#222222 gui=none
	hi Type         guifg=#555555 gui=none
	hi GitGutterAdd guibg=#27303a guifg=#eeeeee
	hi GitGutterChange guibg=#27303a guifg=#eeeeee
	hi GitGutterDelete guibg=#27303a guifg=#eeeeee
	hi Keyword                                  gui=none
	hi LineNr       guifg=#aaaaaa guibg=#ffffff
	hi NonText      guifg=#e3e8ed guibg=#ffffff
	hi Normal       guifg=#000000 guibg=#FFFFFF
	hi Directory    guifg=#27303a
	hi Title        guifg=#000000
	hi Pmenu        guifg=#1a2027 guibg=#f3f8fd
	hi PmenuSel     guifg=#27303a guibg=#e3e8ed
	hi PreProc      guifg=#D81735 gui=none
	hi QuickFixLine guifg=#33373e
	hi SignColumn   guibg=#ffffff guifg=#000000
	hi StatusLine   guibg=#ffffff guifg=#000000 gui=none
	hi StatusLineNC guibg=#ffffff guifg=#000000 gui=none
	hi TabLine      guibg=#ffffff guifg=#000000 gui=none
	hi TabLineFill  guibg=#ffffff guifg=#000000 gui=none
	hi TabLineSel   guibg=#ffffff guifg=#000000 gui=none
	hi VertSplit    guibg=#ffffff guifg=#ffffff gui=none
	hi Visual                     guibg=#eeeeee
	hi idrisMetaVar guifg=#FF5800 gui=underline
  hi ColorColumn  guibg=#f3f8fd
endfunction

function! DarkTheme()
	hi Comment      guifg=#bbbbbb gui=italic
	hi CursorLine   guifg=none guibg=#27303a gui=none
	hi CursorLineNr guibg=#27303a guifg=#eeeeee gui=none
	hi Delimiter    guifg=#eeeeee
	hi Float        guifg=#888888 gui=none
	hi Number       guifg=#888888 gui=none
	hi Function     guifg=#eeeeee
	hi Identifier   guifg=#eeeeee
	hi Operator     guifg=#666666 gui=none
	hi String       guifg=#E1A126
	hi Include      guifg=#666666
	hi Statement    guifg=#D81735 gui=none
	hi Structure    guifg=#D81735 gui=none
	hi Type         guifg=#aaaaaa gui=none
	hi GitGutterAdd guibg=#27303a guifg=#eeeeee
	hi GitGutterChange guibg=#27303a guifg=#eeeeee
	hi GitGutterDelete guibg=#27303a guifg=#eeeeee
	hi Keyword                                  gui=none
	hi LineNr       guifg=#27303a guibg=#17202a
	hi NonText      guifg=#27303a guibg=#1a2027
	hi Normal       guifg=#ffffff guibg=#1a2027
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
	hi ColorColumn  guibg=#27303a
endfunction

function! BlackTheme()
	hi Comment      guifg=#bbbbbb gui=italic
	hi CursorLine   guifg=none guibg=#000000 gui=none
	hi CursorLineNr guibg=#000000 guifg=#27303a gui=none
	hi Delimiter    guifg=#eeeeee
	hi Float        guifg=#888888 gui=none
	hi Number       guifg=#888888 gui=none
	hi Function     guifg=#eeeeee
	hi Identifier   guifg=#eeeeee
	hi Operator     guifg=#666666 gui=none
	hi String       guifg=#E1A126
	hi Include      guifg=#666666
	hi Statement    guifg=#D81735 gui=none
	hi Structure    guifg=#D81735 gui=none
	hi Type         guifg=#aaaaaa gui=none
	hi GitGutterAdd guibg=#000000 guifg=#eeeeee
	hi GitGutterChange guibg=#000000 guifg=#eeeeee
	hi GitGutterDelete guibg=#000000 guifg=#eeeeee
	hi Keyword                                  gui=none
	hi LineNr       guifg=#17202a guibg=#000000
	hi NonText      guifg=#1a2027 guibg=#000000
	hi Normal       guifg=#ffffff guibg=#000000
	hi Directory    guifg=#000000
	hi Title        guifg=#1a2027
	hi Pmenu        guifg=#1a2027 guibg=#f3f8fd
	hi PmenuSel     guifg=#000000 guibg=#e3e8ed
	hi PreProc      guifg=#D81735 gui=none
	hi QuickFixLine guifg=#33373e
	hi SignColumn   guibg=#000000 guifg=#eeeeee
	hi StatusLine   guibg=#000000 guifg=#eeeeee gui=none
	hi StatusLineNC guibg=#000000 guifg=#eeeeee gui=none
	hi TabLine      guibg=#000000 guifg=#eeeeee gui=none
	hi TabLineFill  guibg=#000000 guifg=#eeeeee gui=none
	hi TabLineSel   guibg=#000000 guifg=#eeeeee gui=none
	hi VertSplit    guibg=#000000 guifg=#000000 gui=none
	hi Visual                     guibg=#eeeeee
	hi idrisMetaVar guifg=#FF5800 gui=underline
	hi ColorColumn  guibg=#000000
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
au BufEnter *.idr call ToggleLime()
au VimEnter * call BlackTheme()
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
