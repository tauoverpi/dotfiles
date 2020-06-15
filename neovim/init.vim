filetype indent plugin on
syntax on
let g:gitgutter_max_signs = 5000
call plug#begin('~/.config/nvim/plugged')
Plug 'elmcast/elm-vim', { 'for': 'elm' }
Plug 'airblade/vim-gitgutter'
Plug 'ervandew/supertab'
Plug 'farmergreg/vim-lastplace'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'flowtype/vim-flow', {'for': 'javascript'}
Plug 'godlygeek/tabular'
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
Plug 'luochen1990/rainbow'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'shougo/neosnippet.vim'
Plug 'frasercrmck/formative.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'derekelkins/agda-vim', { 'for': 'agda' }
Plug 'zig-lang/zig.vim', { 'for': ['zig', 'pandoc.markdown'] }
Plug 'zah/nim.vim'
Plug 'jakwings/vim-pony'
Plug 'killerswan/pony-currycomb.vim'
call plug#end()

set cursorline
set autochdir
set incsearch
set backspace=eol,start,indent
set backupdir=~/.config/nvim/tmp/backup/
set clipboard=unnamedplus
set concealcursor=ni
set conceallevel=0
set directory=~/.config/nvim/tmp/swap
set expandtab
set fillchars=vert:\.
set foldlevelstart=99
set foldmethod=syntax
set hlsearch!
set autoread
set ignorecase
set laststatus=2
set lazyredraw
set linebreak
set list
set listchars=tab:\.\ ,extends:>
set magic
set mat=1
set matchpairs=
set mouse=a
set nocompatible
set nohlsearch
set noruler
set noshowmode
set scrolloff=5
set shiftwidth=2
set showbreak=▎
set showmatch
set signcolumn=yes
set smartcase
set smartindent
set smarttab
set synmaxcol=200
set tabstop=2
set tags=tags;
set termguicolors
set textwidth=80
set undodir=~/.config/nvim/tmp/undo/
set undofile
set whichwrap+=<,>,h,l
set wrap

function! ModeColour(mode)
  set statusline=
  set statusline+=█
  set statusline+=%=
  set statusline+=%f
  if a:mode == 'i'
    hi  StatusLine      guifg=#98971a gui=none
  elseif a:mode == 'n'
    hi  StatusLine      guifg=#458588 gui=none
  elseif a:mode == 'r'
    execute 'hi  StatusLine      guifg=#a89984 guibg=none gui=none'
  endif
endfunction

au InsertEnter * call ModeColour('i')
au InsertLeave * call ModeColour('n')
au VimEnter * call ModeColour('n')

function! CleanFile()
	normal mZ
	:%s/\s\+$//e
	":%s/\n\{3,}/\r\r/e
	normal `Z
endfunction

let g:limetoggle = 1
function! LimelightToggle()
	if (g:limetoggle == 0)
		Limelight
		let g:limetoggle = 1
	else
		Limelight!
		let g:limetoggle = 0
	endif
endfunction

let g:light = 1
function! ToggleTheme()
    hi  Boolean         guifg=#458588
    hi  Character       guifg=#b7b083 guibg=#d9d0a5 gui=italic
    hi  ColorColumn     guifg=#000000
    hi  Comment         guifg=#a89984 gui=italic
    hi  Conceal         guifg=#000000
    hi  Conditional     guifg=#665c54
    hi  Constant        guifg=#000000
    "hi  Cursor          guibg=#ffffff
    hi  CursorColumn    guifg=#000000
    hi  CursorLine      guifg=none    guibg=#eae0b6
    hi  CursorLineNr    guifg=#000000
    hi  Debug           guifg=#000000
    hi  Define          guifg=#000000
    hi  Delimiter       guifg=#000000 gui=bold
    hi  DiffAdd         guifg=#000000
    hi  DiffChange      guifg=#000000
    hi  DiffDelete      guifg=#000000
    hi  DiffText        guifg=#000000
    hi  Directory       guifg=#000000
    hi  EndOfBuffer     guifg=#000000
    hi  ErrorMsg        guifg=#000000
    hi  Exception       guifg=#9d0006
    hi  Float           guifg=#458588 gui=bold
    hi  Number          guifg=#458588 gui=bold
    hi  FoldColumn      guifg=#000000
    hi  Folded          guifg=#000000
    hi  Function        guifg=#98971a
    hi  Identifier      guifg=#98971a
    hi  Ignore          guifg=#000000
    hi  IncSearch       guifg=#000000
    hi  Include         guifg=#98971a
    hi  Keyword         guifg=#d65d0e
    hi  Label           guifg=#cc241d
    hi  LineNr          guifg=#000000
    hi  Macro           guifg=#cc241d
    hi  MatchParen      guifg=#000000
    hi  ModeMsg         guifg=#000000
    hi  MoreMsg         guifg=#000000
    hi  MsgArea         guifg=#000000
    hi  MsgSeparator    guifg=#000000
    hi  NonText         guifg=#000000
    hi  Normal          guifg=#000000
    hi  NormalFloat     guifg=#000000
    hi  NormalNC        guifg=#000000
    hi  Operator        guifg=#d65d0e
    hi  Pmenu           guifg=#928374 guibg=#fbf1c7
    hi  PmenuSbar       guifg=#fbf1c7 guibg=none
    hi  PmenuSel        guifg=#fbf1c7 guibg=#b16286
    hi  PmenuThumb      guifg=none    guibg=none
    hi  PreCondit       guifg=#000000
    hi  PreProc         guifg=#000000
    hi  Question        guifg=#000000
    hi  QuickFixLine    guifg=#000000
    hi  Repeat          guifg=#000000
    hi  Search          guifg=#000000
    hi  SignColumn      guifg=#000000
    hi  Special         guifg=#000000
    hi  SpecialChar     guifg=#aaaafa guibg=#1c1c1c
    hi  SpecialComment  guifg=#000000
    hi  SpecialKey      guifg=#000000
    hi  SpellBad        guifg=#cc241d
    hi  SpellCap        guifg=#d79921
    hi  SpellLocal      guifg=#458588
    hi  SpellRare       guifg=#b16286
    hi  Statement       guifg=#7c6f64
    hi  StatusLine      guifg=#a89984 guibg=none gui=none
    hi  StatusLineNC    guifg=#a89984 guibg=none gui=none
    hi  StorageClass    guifg=#000000
    hi  String          guifg=#b7b083 guibg=#eae0b6 gui=italic
    hi  Error           guifg=#000000 guibg=#9d0006
    hi  Structure       guifg=#076678
    hi  Substitute      guifg=#000000
    hi  TabLine         guifg=#000000
    hi  TabLineFill     guifg=#000000
    hi  TabLineSel      guifg=#000000
    hi  Tag             guifg=#000000
    hi  TermCursor      guifg=#000000
    hi  TermCursorNC    guifg=#000000
    hi  Title           guifg=#000000
    hi  Todo            guifg=#d79921 guibg=none gui=underline
    hi  Type            guifg=#b16286 gui=bold
    hi  Typedef         guifg=#000000
    hi  Underlined      guifg=#000000
    hi  VertSplit       guifg=#000000 guibg=#000000
    hi  Visual          guifg=none    guibg=#d5c4a1
    hi  VisualNC        guifg=#000000
    hi  WarningMsg      guifg=#000000
    hi  Whitespace      guifg=#000000
    hi  WildMenu        guifg=#000000
    hi  lCursor         guifg=#000000
    hi jsonKeyword      guifg=#000000

    hi  GitGutterAdd    guifg=#98971a
    hi  GitGutterChange guifg=#d79921
    hi  GitGutterDelete guifg=#458588

    hi  SyntasticErrorSign        guibg=none guifg=#d81735
    hi  SyntasticWarningSign      guibg=none guifg=#ffa800
    hi  SyntasticStyleErrorSign   guibg=none guifg=#d81735
    hi  SyntasticStyleWarningSign guibg=none guifg=#ffa800

    let g:limelight_conceal_guifg = '#c8c094'
    let g:rainbow_conf = {
    \'guifgs': ["#cc241d", "#98971a", "#d79921", "#458588", "#b16286"],
    \}

endfunction

let g:gitgutter_sign_added = '▍ '
let g:gitgutter_sign_modified = '▍ '
let g:gitgutter_sign_removed = '▍ '
let g:gitgutter_sign_removed_first_line = '▍ '
let g:gitgutter_sign_modified_removed = '▍ '

function! Synctex()
        " remove 'silent' for debugging
        execute "silent !zathura --synctex-forward " . line('.') . ":" . col('.') . ":" . bufname('%') . " " . g:syncpdf
endfunction
map <C-enter> :call Synctex()<cr>

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

function Diction()
  :AsyncRun diction /tmp/.tobecheckedforgrammar
endfunction

vm <silent> f :'<,'>!fmt -w 80<CR>
vm <silent> t :Tabularize /\|<CR>
vm <silent> g :'<,'>w! /tmp/.tobecheckedforgrammar<CR> :AsyncRun diction /tmp/.tobecheckedforgrammar<CR>
vm <silent> s :'<,'>w! /tmp/.tobecheckedforgrammar<CR> :AsyncRun style /tmp/.tobecheckedforgrammar<CR>

tno <Esc> <C-\><C-n>
tno <C-b><Esc> <Esc>

nm <F8> :call LimelightToggle()<CR>
nm <F7> :call ToggleTheme()<CR>
nm <F6> :call RainbowToggle()<CR>

nm <C-n> :tabnew<CR>

"ino <Up> <NOP>
"ino <Down> <NOP>
"ino <Right> <NOP>
"ino <Left> <NOP>

nno <silent> k gk
nno <silent> j gj
nno <silent> 0 g0
nno <silent> $ g$

let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#codeblocks#embeds#langs =
  \ [ "literatehaskell=lhaskell", "bash=sh", "zig", "elm", "go", "scheme"
  \ , "c", "dot"
  \ ]
let g:pymode_lint_on_write = 0
let g:syntastic_error_symbol = '▊ '
let g:syntastic_warning_symbol = '▊ '
let g:syntastic_style_warning_symbol = '▊ '
let g:syntastic_style_error_symbol = '▊ '

let g:neosnippet#disable_runtime_snippets = {
		\   '_' : 1,
		\ }
let g:neosnippet#snippets_directory='~/config/neovim/snippets/'
let g:rainbow_active = 1

let g:limelight_paragraph_span = 0
let g:markdown_fenced_languages =
\ ["c", "cpp", "python", "sh", "yaml", "html"
\ , "css", "haskell", "scheme", "zig"
\ , "javascript", "cs"
\ ]

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
nmap <leader>d <Plug>FormativeFile

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Stuff
au BufNewFile,BufRead * RainbowToggleOn
au BufNewFile,BufRead * Limelight
au BufNewFile,BufRead *.c,*.cs set expandtab!
"au CursorHold * execute 'hi CursorLineNr guibg=#221d1f guifg=#30ff6a'
"au InsertEnter * execute 'hi CursorLineNr guibg=#221d1f guifg=#ff9c30'
"au InsertLeave * execute 'hi CursorLineNr guibg=#221d1f guifg=#000000'
au BufWrite * call CleanFile()
au BufWritePost * silent !touch %
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc

call ToggleTheme()
