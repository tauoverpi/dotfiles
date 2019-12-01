filetype indent plugin on
syntax sync minlines=256
"set laststatus=2
"set number
"set relativenumber number
"set showtabline=2
set ai
set autochdir
set backspace=eol,start,indent
set backupdir=~/.config/nvim/tmp/backup/
set clipboard=unnamedplus
set concealcursor=ni
set conceallevel=2
set cursorline
set directory=~/.config/nvim/tmp/swap
set foldlevelstart=99
set foldmethod=syntax
set hlsearch!
set ignorecase
set incsearch
set laststatus=0
set lazyredraw
set lbr
set linebreak
set list
set listchars=tab:\▏\ ,eol:↵,extends:❯
set magic
set mat=1
set mouse=a
set nocompatible
set nohlsearch
set noruler
set noshowmode
set number
set scrolloff=5
set shiftwidth=2
set showmatch
set si
set signcolumn=yes
set smartcase
set smarttab
set sw=4
set t_Co=256
set tabstop=2
set tags=tags;
set termguicolors
set textwidth=100
set ts=4
set tw=500
set undodir=~/.config/nvim/tmp/undo/
set undofile
set whichwrap+=<,>,h,l
set wrap

function! CleanFile()
	if (&ft == "text")
		:%!fmt -w 100
	endif
	normal mZ
	:%s/\s\+$//e
	:%s/\n\{3,}/\r\r/e
	normal `Z
endfunction

function! ScribbleCheck()
	AsyncRun scribble --dest-name output.txt --text ++arg --text % && java -jar $HOME/build/LT/LanguageTool-4.8-SNAPSHOT/languagetool-commandline.jar -c utf8 -d UPPERCASE_SENTENCE_START -l en-US output.txt
endfunction

function! Lt()
	AsyncRun java -jar $HOME/build/LT/LanguageTool-4.8-SNAPSHOT/languagetool-commandline.jar -c utf8 -d UPPERCASE_SENTENCE_START -l en-US %
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

let g:syntastic_error_symbol = '⏺'
let g:syntastic_warning_symbol = '⏺'
let g:syntastic_style_warning_symbol = '⏺'
let g:syntastic_style_error_symbol = '⏺'

let g:deoplete#enable_at_startup = 1
let g:slime_target = "tmux"

hi SyntasticErrorSign guibg=none ctermbg=none
hi SyntasticWarningSign guibg=none ctermbg=none
hi SyntasticStyleErrorSign guibg=none ctermbg=none
hi SyntasticStyleWarningSign guibg=none ctermbg=none

let g:syntastic_haskell_checkers = ['hlint']
"let g:vim_annotations_offset = '/.liquid/'
"let g:syntastic_mode_map = { 'mode': 'active' }
"let g:syntastic_haskell_liquid_args = "-d"

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
	hi SyntasticError guifg=#ff3430
	hi SyntasticErrorSign guifg=#ff3430
	hi SyntasticWarning guifg=#ffff30
	hi SyntasticWarningSign guifg=#ffff30
	hi SyntasticStyleError guifg=#ff3430
	hi SyntasticStyleWarning guifg=#ffff30

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

"autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

call plug#begin('~/.config/nvim/plugged')
"Plug 'kien/ctrlp.vim'
"Plug 'kien/rainbow_parentheses.vim'
"Plug 'natebosch/vim-lsc'
Plug 'w0rp/ale'
Plug 'ervandew/supertab'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'farmergreg/vim-lastplace'
Plug 'floobits/floobits-neovim'
Plug 'godlygeek/tabular'
Plug 'idris-hackers/idris-vim', { 'for': 'idris' }
Plug 'jpalardy/vim-slime'
Plug 'junegunn/limelight.vim'
Plug 'panagosg7/vim-annotations'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'raichoo/haskell-vim', { 'for': 'haskell' }
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/loremipsum', { 'on': 'Loremipsum' }
Plug 'vim-scripts/paredit.vim', { 'for': 'scheme' }
call plug#end()

" Stuff
au BufNewFile,BufFilePre,BufRead *.md set filetype=none
au BufWritePost *.md AsyncRun pandoc % -o /tmp/pandoc.pdf
au BufNewFile,BufRead *.c copen
au BufNewFile,BufRead *.cats set filetype=ats | source $HOME/.config/nvim/ats.vim
au BufNewFile,BufRead *.dats set filetype=ats | source $HOME/.config/nvim/ats.vim
au BufNewFile,BufRead *.lidr set filetype=idris | set filetype=lidris
au BufNewFile,BufRead *.rkt hi error guibg=none
au BufNewFile,BufRead *.sats set filetype=ats | source $HOME/.config/nvim/ats.vim
au BufNewFile,BufRead *.scrbl set filetype=scribble
au BufNewFile,BufRead *.texi,*.idr,*.hs,*.scm,*.rkt,*.lhs,*.lidr,*.sats,*.ipkg,*.txt,*.m,*.purs,*.md set expandtab
au BufWrite * call CleanFile()
au BufWrite *.hs AsyncRun liquid -q %
au BufWritePost *.c AsyncRun make check
au BufWritePost *.scrbl AsyncRun scribble --dest /tmp/scribble --pdf %
au BufWritePost *.dats AsyncRun patsopt --typecheck -d %
au BufWritePost *.sats AsyncRun patsopt --typecheck -s %
au BufWritePost *.txt AsyncRun diction -s %
au VimEnter * call SetTheme()
au VimEnter,BufRead,BufNewFile,BufWrite * call UpdateStatus()
au VimLeave * call ClearStatus()
