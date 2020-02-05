filetype indent plugin on
syntax on
"set laststatus=2
"set number
"set relativenumber number
"set showtabline=2
set autoindent
set autochdir
set backspace=eol,start,indent
set backupdir=~/.config/nvim/tmp/backup/
set fillchars=vert:\.
set clipboard=unnamedplus
set concealcursor=ni
set conceallevel=0
"set cursorline
set directory=~/.config/nvim/tmp/swap
set foldlevelstart=99
set foldmethod=syntax
set hlsearch!
set synmaxcol=200
set ignorecase
set incsearch
set laststatus=0
set lazyredraw
set linebreak
set list
set listchars=tab:\.\ ,extends:>
set showbreak=>\ \ \
set magic
set mat=1
set mouse=a
set nocompatible
set nohlsearch
set noruler
set noshowmode
set matchpairs=
"set number
set scrolloff=5
set shiftwidth=2
set showmatch
set smartindent
set signcolumn=yes
set smartcase
set smarttab
set shiftwidth=4
set tabstop=4
set tags=tags;
set termguicolors
set textwidth=80
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
	":%s/\n\{3,}/\r\r/e
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

let g:neosnippet#disable_runtime_snippets = {
		\   '_' : 1,
		\ }
"let g:neosnippet#snippets_directory='~/projects/dotfiles/neovim/snippets/'
let g:rainbow_active = 1

let g:deoplete#enable_at_startup = 1
let g:syntastic_python_python_exec = '/path/to/python3'
let g:syntastic_python_pyflakes_exe = 'python3 -m pyflakes'
let g:syntastic_error_symbol = '_'
let g:syntastic_warning_symbol = '_'
let g:syntastic_style_warning_symbol = '_'
let g:syntastic_style_error_symbol = '_'

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
let g:limelight_conceal_guifg = "#ccbbaa"
let g:limelight_paragraph_span = 0
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#codeblocks#embeds#langs =
			\ ["c", "cpp", "python", "sh", "yaml", "html"
			\ , "css", "haskell", "scheme", "prolog"
			\ , "javascript", "cs"
			\ , "html=cshtml"
			\ ]

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

function! UpdateStatus()
	call writefile([expand('%')
				\ . " " . line('.')
				\ . repeat(' ', 4 - len(line('.')))
				\ . " " . col('.')
				\ . repeat(' ', 3 - len(col('.')))], $HOME . "/.vimstatus")
	call execute("!tmux refresh-client -S")
endfunction

function! TangleFiles()
	AsyncRun tan % &&
				\ pandoc -f "markdown+fenced_code_attributes+citations+all_symbols_escapable+fenced_divs+multiline_tables+fenced_divs+bracketed_spans"
				\ --pdf-engine=xelatex -V CJKmainfont="Noto Sans Mono CJK JP"
				\ % -F diagrams-pandoc -o /tmp/pandoc.pdf &&
				\ revealjs % -o /tmp/pandoc.html
endfunction

function! ClearStatus()
	call delete($HOME . "/.vimstatus")
	call execute("!tmux refresh-client -S")
endfunction

call plug#begin('~/.config/nvim/plugged')
"Plug 'w0rp/ale'
Plug 'ervandew/supertab'
"Plug 'elmcast/elm-vim'
"Plug 'cheap-glitch/vim-v', { 'for': 'v' }
Plug 'farmergreg/vim-lastplace'
Plug 'shougo/neosnippet.vim'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'floobits/floobits-neovim'
Plug 'godlygeek/tabular'
"Plug 'idris-hackers/idris-vim', { 'for': 'idris' }
"Plug 'jpalardy/vim-slime'
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
"Plug 'panagosg7/vim-annotations'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
"Plug 'raichoo/haskell-vim', { 'for': 'haskell' }
Plug 'scrooloose/nerdtree'
Plug 'flowtype/vim-flow', {'for': 'javascript'}
"Plug 'scrooloose/syntastic'
Plug 'skywind3000/asyncrun.vim'
Plug 'luochen1990/rainbow', { 'for': ['scheme', 'zig', 'javascript'] }
"Plug 'tpope/vim-surround'
"Plug 'oranget/vim-csharp'
"Plug 'vim-pandoc/vim-pandoc-syntax'
"Plug 'vim-scripts/loremipsum', { 'on': 'Loremipsum' }
"Plug 'vim-scripts/paredit.vim', { 'for': 'scheme' }
"Plug 'zah/nim.vim'
"Plug 'rhysd/vim-crystal'
Plug 'zig-lang/zig.vim', { 'for': 'zig' }
"Plug 'junegunn/goyo.vim'
call plug#end()

" Stuff
"au BufNewFile,BufRead *.zig,*.scheme RainbowToggleOn
au BufNewFile,BufRead *.zig,*.scheme Limelight
au BufNewFile,BufRead *.texi,*.idr,*.hs,*.scm,*.rkt,*.lhs,*.lidr,*.sats,*.ipkg,*.txt,*.m,*.purs,*.md set expandtab
"au CursorHold * execute 'hi CursorLineNr guibg=#221d1f guifg=#30ff6a'
"au InsertEnter * execute 'hi CursorLineNr guibg=#221d1f guifg=#ff9c30'
"au InsertLeave * execute 'hi CursorLineNr guibg=#221d1f guifg=#000000'
au BufWrite * call CleanFile()

hi Boolean         guifg=#776655
hi Character       guifg=#776655
hi ColorColumn     guifg=#000000
hi Comment         guifg=#ccbbaa guibg=#ffeedd
hi Conceal         guifg=#000000
hi Conditional     guifg=#000000
hi Constant        guifg=#000000
hi Cursor          guifg=#000000
hi CursorColumn    guifg=#000000
hi CursorLine      guifg=#000000
hi CursorLineNr    guifg=#000000
hi Debug           guifg=#000000
hi Define          guifg=#000000
hi Delimiter       guifg=#000000
hi DiffAdd         guifg=#000000
hi DiffChange      guifg=#000000
hi DiffDelete      guifg=#000000
hi DiffText        guifg=#000000
hi Directory       guifg=#000000
hi EndOfBuffer     guifg=#000000
hi ErrorMsg        guifg=#000000
hi Exception       guifg=#000000
hi Float           guifg=#776655
hi Number          guifg=#776655
hi FoldColumn      guifg=#000000
hi Folded          guifg=#000000
hi Function        guifg=#443322 gui=italic
hi Identifier      guifg=#000000
hi Ignore          guifg=#000000
hi IncSearch       guifg=#000000
hi Include         guifg=#000000
hi Keyword         guifg=#332211
hi Label           guifg=#000000
hi LineNr          guifg=#000000
hi Macro           guifg=#000000
hi MatchParen      guifg=#000000
hi ModeMsg         guifg=#000000
hi MoreMsg         guifg=#000000
hi MsgArea         guifg=#000000
hi MsgSeparator    guifg=#000000
hi NonText         guifg=#000000
hi Normal          guifg=#000000 guibg=#ffeedd
hi NormalFloat     guifg=#000000
hi NormalNC        guifg=#000000
hi Operator        guifg=#000000
hi Pmenu           guifg=#000000 guibg=#ddccbb
hi PmenuSbar       guifg=#000000 guibg=#665544
hi PmenuSel        guifg=#000000 guibg=#eeddcc
hi PmenuThumb      guifg=#000000 guibg=#665544
hi PreCondit       guifg=#000000
hi PreProc         guifg=#000000
hi Question        guifg=#000000
hi QuickFixLine    guifg=#000000
hi Repeat          guifg=#000000
hi Search          guifg=#000000
hi SignColumn      guifg=#000000 guibg=#ffeedd
hi Special         guifg=#998877
hi SpecialChar     guifg=#999999 guibg=#f5e5d5
hi SpecialComment  guifg=#000000
hi SpecialKey      guifg=#000000
hi SpellBad        guibg=#aa9988
hi SpellCap        guifg=#000000
hi SpellLocal      guifg=#000000
hi SpellRare       guifg=#000000
hi Statement       guifg=#776655
hi StatusLine      guifg=#000000
hi StatusLineNC    guifg=#000000
hi StorageClass    guifg=#000000
hi String          guifg=#998877 guibg=#f3e3d3
hi Structure       guifg=#776655
hi Substitute      guifg=#776655
hi TabLine         guifg=#000000
hi TabLineFill     guifg=#000000
hi TabLineSel      guifg=#000000
hi Tag             guifg=#000000
hi TermCursor      guifg=#000000
hi TermCursorNC    guifg=#000000
hi Title           guifg=#000000
hi Todo            guifg=#e36209
hi Type            guifg=#554433
hi Typedef         guifg=#000000
hi Underlined      guifg=#000000
hi VertSplit       guifg=#000000
hi Visual                        guibg=#ddccbb
hi VisualNC                      guibg=#ddccbb
hi WarningMsg      guifg=#000000
hi Whitespace      guifg=#d5c5b5
hi WildMenu        guifg=#000000
hi lCursor         guifg=#000000

let g:rainbow_conf = {
\	'guifgs': ["#ccbbaa", "#aa9988", "#887766"],
\}

