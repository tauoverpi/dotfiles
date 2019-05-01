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
set ignorecase
set incsearch
set lazyredraw
set lbr
set listchars=tab:\|\ ,eol:¬,extends:❯,precedes:❮,nbsp:▩
set magic
set mat=1
set mouse=a
set nohlsearch
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

let g:theme = "dark"

function Link()
	hi link String         Constant
	hi link Character      Constant
	hi link Number         Constant
	hi link Boolean        Constant
	hi link Float          Number
	hi link Function       Identifier
	hi link Conditional    Statement
	hi link Repeat         Statement
	hi link Label          Statement
	hi link Operator       Statement
	hi link Keyword        Statement
	hi link Exception      Statement
	hi link Include        PreProc
	hi link Define         PreProc
	hi link Macro          PreProc
	hi link PreCondit      PreProc
	hi link StorageClass   Type
	hi link Structure      Type
	hi link Typedef        Type
	hi link SpecialChar    Special
	hi link Delimiter      Special
	hi link SpecialComment Special
	hi link Debug          Special
endfunction

function Red()
	hi Normal       guifg=#d00000  guibg=#100000
	hi ErrorMsg     guifg=#ffffff  guibg=#ff0000
	hi Visual       guifg=#100000  guibg=#900000
	hi Todo         guifg=#100000  guibg=#ff0000
	hi NonText      guifg=#ff6060
	hi Search       guifg=#100000  guibg=#ff6060
	hi Question     guifg=#ff8080
	hi MatchParen   guifg=#ff9090  guibg=bg       gui=bold
	hi LineNr       guifg=#ff6060
	hi Directory    guifg=#d04040
	hi Folded       guifg=#100000  guibg=#600000
	hi ColorColumn  guibg=#300000
	hi Error        guibg=#ff8000
	hi CursorLine                  guibg=#200000
	hi CursorLineNr guifg=#ff6060  guibg=#200000

	" Splitter
	hi StatusLine   guifg=#ff2020
	hi StatusLineNC guifg=#ff2020
	hi VertSplit    guifg=#ff2020

	" Popup menu
	hi Pmenu        guifg=#ff8080  guibg=#200000
	hi PmenuSel     guifg=#100000  guibg=#ff8080
	hi PmenuSbar    guibg=#401010
	hi PmenuThumb   guibg=#a04040

	" Code colors
	hi Comment      guifg=#a04040
	hi Constant     guifg=#800000
	hi Special      guifg=#ff3030
	hi Identifier   guifg=#700000
	hi Statement    guifg=#ff4040
	hi PreProc      guifg=#c00000
	hi Type         guifg=#ff3030
	hi Underlined                 term=underline
	hi Ignore       guifg=bg
	hi Operator     guifg=#ff3030

	call Link()
endfunction

function Green()
	hi Normal       guifg=#00d000  guibg=#001000
	hi ErrorMsg     guifg=#ffffff  guibg=#ff0000
	hi Visual       guifg=#001000  guibg=#009000
	hi Todo         guifg=#001000  guibg=#00ff00
	hi NonText      guifg=#60ff60
	hi Search       guifg=#001000  guibg=#60ff60
	hi Question     guifg=#80ff80
	hi MatchParen   guifg=#90ff90  guibg=bg      gui=bold
	hi LineNr       guifg=#60ff60
	hi Directory    guifg=#40d040
	hi Folded       guifg=#001000  guibg=#006000
	hi ColorColumn  guibg=#003000
	hi Error        guibg=#ff8000
	hi CursorLine                  guibg=#002000
	hi CursorLineNr guifg=#60ff60  guibg=#002000

	" Splitter
	hi StatusLine   guifg=#20ff20
	hi StatusLineNC guifg=#20ff20
	hi VertSplit    guifg=#20ff20

	" Popup menu
	hi Pmenu        guifg=#80ff80  guibg=#002000
	hi PmenuSel     guifg=#001000  guibg=#80ff80
	hi PmenuSbar    guibg=#104010
	hi PmenuThumb   guibg=#40a040

	" Code colors
	hi Comment      guifg=#40a040
	hi Constant     guifg=#008000
	hi Special      guifg=#30ff30
	hi Identifier   guifg=#007000
	hi Statement    guifg=#40ff40
	hi PreProc      guifg=#00c000
	hi Type         guifg=#30ff30
	hi Underlined                  term=underline
	hi Ignore       guifg=bg
	hi Operator     guifg=#30ff30

	call Link()
endfunction

function Yellow()
	hi Normal       guifg=#d0d000  guibg=#101000
	hi ErrorMsg     guifg=#ffffff  guibg=#0000ff
	hi Visual       guifg=#101000  guibg=#909000
	hi Todo         guifg=#101000  guibg=#ffff00
	hi NonText      guifg=#ffff60
	hi Search       guifg=#101000  guibg=#ffff60
	hi Question     guifg=#ffff80
	hi MatchParen   guifg=#ffff90  guibg=bg      gui=bold
	hi LineNr       guifg=#ffff60
	hi Directory    guifg=#d0d040
	hi Folded       guifg=#101000  guibg=#606000
	hi ColorColumn  guibg=#303000
	hi Error        guibg=#8080ff
	hi CursorLine                  guibg=#202000
	hi CursorLineNr guifg=#ffff60  guibg=#202000

	" Splitter
	hi StatusLine   guifg=#ffff20
	hi StatusLineNC guifg=#ffff20
	hi VertSplit    guifg=#ffff20

	" Popup menu
	hi Pmenu        guifg=#ffff80  guibg=#202000
	hi PmenuSel     guifg=#101000  guibg=#ffff80
	hi PmenuSbar    guibg=#404010
	hi PmenuThumb   guibg=#a0a040

	" Code colors
	hi Comment      guifg=#a0a040
	hi Constant     guifg=#808000
	hi Special      guifg=#ffff30
	hi Identifier   guifg=#707000
	hi Statement    guifg=#ffff40
	hi PreProc      guifg=#c0c000
	hi Type         guifg=#ffff30
	hi Underlined                  term=underline
	hi Ignore       guifg=bg
	hi Operator     guifg=#ffff30

	call Link()
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
		call Green()
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
" au BufNewFile,BufRead *.scm,*.clj,*.lisp RainbowToggleOn
au BufEnter *.idr call Categories() | call ToggleLime()
au VimEnter * call Green() | RainbowToggleOff
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
