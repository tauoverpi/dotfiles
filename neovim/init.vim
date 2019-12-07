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
set fillchars=vert:\▏
set clipboard=unnamedplus
set concealcursor=ni
set conceallevel=0
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
set textwidth=80
set ts=4
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
	AsyncRun java -jar $HOME/build/LT/LanguageTool-4.8-SNAPSHOT/languagetool-commandline.jar -c utf8 -d UPPERCASE_SENTENCE_START -l en-GB %
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

let g:syntastic_python_python_exec = '/path/to/python3'
let g:syntastic_python_pyflakes_exe = 'python3 -m pyflakes'
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
let g:limelight_conceal_guifg = "#110c0f"
let g:pandoc#syntax#codeblocks#embeds#langs=["c", "cpp", "python", "sh", "asm", "yaml", "html", "css", "vim", "go", "haskell", "scheme", "prolog", "elisp", "ruby", "javascript", "zsh", "ocaml", "rust", "cs", "html=cshtml"]
let g:pandoc#formatting#mode = 'h'
let g:pandoc#modules#disabled = ["folding","formatting"]
"let g:pandoc#syntax#conceal#cchar_overrides = {"codelang": ""}
let g:vimtex_compiler_progname = 'nvr'
let g:pandoc#syntax#conceal#use = 0

function! SetTheme()
	let dark    = "#110c0f"
	let red     = "#ff3430"
	let green   = "#30ff6a"
	let yellow  = "#ff9c30"
	let blue    = "#3064ff"
	let cyan    = "#D8AC9C"
	let magenta = "#E7C5B9"
	let light   = "#d3d5db"
	let orange  = "#939599"
	let black   = "#000000"
	let white   = "#ffffff"

	"au CursorHold * execute 'hi CursorLineNr guibg=#221d1f guifg=#30ff6a'
	au InsertEnter * execute 'hi CursorLineNr guibg=#221d1f guifg=#ff9c30'
	au InsertLeave * execute 'hi CursorLineNr guibg=#221d1f guifg=#000000'
	execute 'hi SyntasticError guifg=' . red
	execute 'hi SyntasticErrorSign guifg=' . red
	execute 'hi SyntasticWarning guifg=' . yellow
	execute 'hi SyntasticWarningSign guifg=' . yellow
	execute 'hi SyntasticStyleError guifg=' . red
	execute 'hi SyntasticStyleWarning guifg=' . yellow

	execute 'hi htmlItalic gui=none guibg=none guifg=' . white
	execute 'hi htmlBoldItalic gui=none guibg=none guifg=' . white
	execute 'hi htmlBold gui=none guibg=none guifg=' . white
	execute 'hi htmlH1 gui=none guibg=none guifg=' . red
	execute 'hi htmlH2 gui=none guibg=none guifg=' . yellow
	execute 'hi htmlH3 gui=none guibg=none guifg=' . green
	execute 'hi htmlH4 gui=none guibg=none guifg=' . blue
	execute 'hi htmlH5 gui=none guibg=none guifg=' . cyan
	execute 'hi htmlH6 gui=none guibg=none guifg=' . magenta

	execute 'hi MatchParen guibg=#443f3f guifg=' . white
	execute 'hi Normal guifg=' . light . ' gui=italic'
	execute 'hi Todo guifg=' . red . ' guibg=none gui=underline'
	execute 'hi Comment guifg=#221d1f'
	execute 'hi Operator guifg=' . blue
	execute 'hi Structure guifg=' . red
	execute 'hi Statement guifg=' . blue
	execute 'hi SpecialChar guifg=' . white
	execute 'hi Macro guifg=' . yellow
	execute 'hi Include guifg=' . yellow
	execute 'hi Identifier guifg=' . red
	execute 'hi Special guifg=' . white
	execute 'hi Delimiter guifg=' . red
	execute 'hi Function guifg=' . yellow
	execute 'hi Type guifg=' . red
	execute 'hi String guifg=' . green
	execute 'hi Character guifg=' . green
	execute 'hi Label guifg=' . white
	execute 'hi Constant guifg=' . green
	execute 'hi Number guifg=' . green
	execute 'hi Float guifg=' . green
	execute 'hi PreProc guifg=' . orange
	execute 'hi Error gui=underline guifg=' . red
	execute 'hi Conditional guifg=' . orange
	execute 'hi LineNr       guifg=#221d1f guibg=none'
	execute 'hi NonText      guifg=#221d1f guibg=none'
	execute 'hi Pmenu        guifg=#221d1f guibg=' . black . ' gui=none'
	execute 'hi PmenuSel     guifg=' . red . ' guibg=' . black
	execute 'hi PmenuSbar    guifg=#221d1f guibg=' . black
	execute 'hi PmenuThumb   guifg=' . red . ' guibg=' . black
	execute 'hi SignColumn   guibg=none guifg=#221d1f'
	execute 'hi StatusLine   guibg=none guifg=#221d1f gui=none'
	execute 'hi StatusLineNC guibg=none guifg=#221d1f gui=none'
	execute 'hi TabLine      guibg=none guifg=#221d1f gui=none'
	execute 'hi TabLineFill  guibg=none guifg=#221d1f gui=none'
	execute 'hi TabLineSel   guibg=none guifg=#221d1f gui=none'
	execute 'hi VertSplit    guibg=' . black . ' guifg=#221d1f gui=none'
	execute 'hi CursorLineNr guibg=#221d1f guifg=' . black
	execute 'hi CursorLine   guibg=#120d0f'
	execute 'hi Visual       guibg=#221d1f'

	execute 'hi QuickFixLine guifg=' . red . ' guibg=' . black
	execute 'hi tcshShellVar guifg=' . green
endfunction

function! UpdateStatus()
	call writefile([expand('%')
				\ . " l" . line('.')
				\ . repeat(' ', 4 - len(line('.')))
				\ . " c" . col('.')
				\ . repeat(' ', 3 - len(col('.')))], $HOME . "/.vimstatus")
	call execute("!tmux refresh-client -S")
endfunction

function! TangleFiles()
	AsyncRun tan % && pandoc % -F diagrams-pandoc -o /tmp/pandoc.pdf && revealjs % -o /tmp/pandoc.html
endfunction

function! ClearStatus()
	call delete($HOME . "/.vimstatus")
	call execute("!tmux refresh-client -S")
endfunction

"autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

call plug#begin('~/.config/nvim/plugged')
Plug 'w0rp/ale'
Plug 'ervandew/supertab'
Plug 'farmergreg/vim-lastplace'
Plug 'floobits/floobits-neovim'
Plug 'godlygeek/tabular'
Plug 'idris-hackers/idris-vim', { 'for': 'idris' }
"Plug 'jpalardy/vim-slime'
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
"Plug 'panagosg7/vim-annotations'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'raichoo/haskell-vim', { 'for': 'haskell' }
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'skywind3000/asyncrun.vim'
"Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
"Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'oranget/vim-csharp'
Plug 'vim-scripts/loremipsum', { 'on': 'Loremipsum' }
Plug 'vim-scripts/paredit.vim', { 'for': 'scheme' }
call plug#end()

" Stuff
au BufWritePost *.md call TangleFiles()
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
au BufNewFile,BufRead *.md set et
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


