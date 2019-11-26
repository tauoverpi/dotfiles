set nocompatible
set list
set ai
set number
set autochdir
set backspace=eol,start,indent
set backupdir=~/.config/nvim/tmp/backup/
set conceallevel=2
set concealcursor=ni
set directory=~/.config/nvim/tmp/swap
set hlsearch!
set sw=4
set ts=4
set cursorline
set signcolumn=yes
set ignorecase
set incsearch
set lazyredraw
set lbr
set listchars=tab:\▏\ ,eol:¬,extends:❯
set magic
set mat=1
set mouse=a
set nohlsearch
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
set laststatus=0
set noruler
set tw=500
set undodir=~/.config/nvim/tmp/undo/
set termguicolors
"set number
"set relativenumber number
set undofile
set whichwrap+=<,>,h,l
"set showtabline=2
set wrap
set linebreak
"set laststatus=2
set foldlevelstart=99
set foldmethod=syntax
set clipboard=unnamedplus

function! CleanFile()
	if (&ft == "text")
		:%!fmt
	endif
	normal mZ
	:%s/\s\+$//e
	:%s/\n\{3,}/\r\r/e
	normal `Z
endfunction

nm <F10> :AsyncRun make <CR>
nm <S-h> <C-w><
nm <S-j> <C-w>-
nm <S-k> <C-w>+
nm <S-l> <C-w>>
" PANE MOVEMENT
nm <Up> <C-w>k
nm <Left> <C-w>h
nm <Right> <C-w>l
nm <Down> <C-w>j
" TAB MOVEMENT
nm <C-Left> :tabprevious<CR>
nm <C-Right> :tabnext<CR>

tno <Esc> <C-\><C-n>
tno <C-b><Esc> <Esc>

nm <C-n> :tabnew<CR>

"ino <Tab> <C-R>=Tab_Or_Complete()<CR>
ino <Up> <NOP>
ino <Down> <NOP>
ino <Right> <NOP>
ino <Left> <NOP>

nno <silent> k gk
nno <silent> j gj
nno <silent> 0 g0
nno <silent> $ g$

let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'
let g:syntastic_style_error_symbol = '✠'

let g:deoplete#enable_at_startup = 1
let g:slime_target = "tmux"

hi SyntasticErrorSign guibg=none ctermbg=none
hi SyntasticWarningSign guibg=none ctermbg=none
hi SyntasticStyleErrorSign guibg=none ctermbg=none
hi SyntasticStyleWarningSign guibg=none ctermbg=none

let color0  = "#110c0f"
let color1  = "#30649F"
let color2  = "#5C749A"
let color3  = "#798198"
let color4  = "#9F9EA5"
let color5  = "#D8AC9C"
let color6  = "#E7C5B9"
let color7  = "#d3d5db"
let color8  = "#939599"
let color9  = "#30649F"
let color10 = "#5C749A"
let color11 = "#798198"
let color12 = "#9F9EA5"
let color13 = "#D8AC9C"
let color14 = "#E7C5B9"
let color15 = "#d3d5db"

function! SetTheme()
	hi Normal guifg=#d3d5db gui=italic
	hi Todo guifg=#30649F guibg=none gui=underline
	hi Comment guifg=#221d1f
	hi Operator guifg=#5C749A
	hi Structure guifg=#30649F
	hi Statement guifg=#D8AC9C
	hi SpecialChar guifg=#ffffff
	hi Macro guifg=#798198
	hi Include guifg=#E7C5B9
	hi Identifier guifg=#30649F
	hi Special guifg=#ffffff
	hi Delimiter guifg=#30649F
	hi Function guifg=#9F9EA5
	hi Type guifg=#30649F
	hi String guifg=#798198
	hi Character guifg=#798198
	hi Label guifg=#ffffff
	hi Constant guifg=#D8AC9C
	hi Number guifg=#5C749A
	hi Float guifg=#5C749A
	hi PreProc guifg=#939599
	hi Error guifg=#110c0f guibg=#30649F
	hi Conditional guifg=#939599
	hi LineNr       guifg=#221d1f guibg=none
	hi NonText      guifg=#221d1f guibg=none
	hi Pmenu        guifg=#221d1f guibg=#000000 gui=none
	hi PmenuSel     guifg=#30649F guibg=#000000
	hi PmenuSbar    guifg=#221d1f guibg=#000000
	hi PmenuThumb   guifg=#30649F guibg=#000000
	hi SignColumn   guibg=none guifg=#221d1f
	hi StatusLine   guibg=none guifg=#221d1f gui=none
	hi StatusLineNC guibg=none guifg=#221d1f gui=none
	hi TabLine      guibg=none guifg=#221d1f gui=none
	hi TabLineFill  guibg=none guifg=#221d1f gui=none
	hi TabLineSel   guibg=none guifg=#221d1f gui=none
	hi VertSplit    guibg=#000000 guifg=#000000 gui=none
	hi CursorLineNr guibg=#221d1f guifg=#000000
	hi CursorLine   guibg=#120d0f
	hi Visual       guibg=#221d1f

	hi QuickFixLine guifg=#30649F guibg=#000000
	hi tcshShellVar guifg=#5C749A
endfunction

function! UpdateStatus()
	call writefile([expand('%')
				\ . " l" . line('.')
				\ . repeat(' ', 4 - len(line('.')))
				\ . " c" . col('.')
				\ . repeat(' ', 3 - len(col('.')))], $HOME . "/.vimstatus")
	call execute("!tmux refresh-client -S")
endfunction

function! ClearStatus()
	call delete($HOME . "/.vimstatus")
	call execute("!tmux refresh-client -S")
endfunction

call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/limelight.vim'
Plug 'raichoo/haskell-vim'
Plug 'idris-hackers/idris-vim'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'jpalardy/vim-slime'
Plug 'vim-scripts/paredit.vim', { 'for': 'scheme' }
Plug 'skywind3000/asyncrun.vim'
Plug 'pangloss/vim-javascript'
Plug 'natebosch/vim-lsc'
Plug 'vim-scripts/loremipsum'
Plug 'farmergreg/vim-lastplace'
Plug 'luochen1990/rainbow'
call plug#end()

" Stuff
au BufNewFile,BufRead *.texi,*.idr,*.hs,*.scm,*.rkt,*.lhs,*.lidr,*.sats,*.ipkg,*.txt,*.m,*.purs,*.md set expandtab
au BufNewFile,BufRead *.rkt hi error guibg=none
au BufWrite * call CleanFile()
au BufWritePost *.dats AsyncRun patsopt --typecheck -d %
au BufWritePost *.sats AsyncRun patsopt --typecheck -s %
au BufWritePost *.c AsyncRun make check
au BufWritePost *.txt AsyncRun diction -s %
au BufNewFile,BufRead *.lidr set filetype=idris | set filetype=lidris
au BufNewFile,BufRead *.c copen
au BufNewFile,BufRead *.dats set filetype=ats | source $HOME/.config/nvim/ats.vim
au BufNewFile,BufRead *.sats set filetype=ats | source $HOME/.config/nvim/ats.vim
au BufNewFile,BufRead *.cats set filetype=ats | source $HOME/.config/nvim/ats.vim
au VimEnter * call SetTheme()
au VimEnter,BufRead,BufNewFile,BufWrite * call UpdateStatus()
au VimLeave * call ClearStatus()
