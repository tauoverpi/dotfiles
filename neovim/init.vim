filetype indent plugin on
syntax on

set cursorline
set autochdir
set incsearch
set backspace=eol,start,indent
set clipboard=unnamedplus
set concealcursor=ni
set conceallevel=0
set expandtab
set fillchars=vert:\▕
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
    hi  Character       guifg=#666666 guibg=#333333 gui=italic
    hi  ColorColumn     guifg=#ffffff
    hi  Comment         guifg=#a89984 gui=italic
    hi  Conceal         guifg=#ffffff
    hi  Conditional     guifg=#665c54
    hi  Constant        guifg=#ffffff
    "hi  Cursor          guibg=#ffffff
    hi  CursorColumn    guifg=#ffffff
    hi  CursorLine      guifg=none    guibg=#050505
    hi  CursorLineNr    guifg=#ffffff
    hi  Debug           guifg=#ffffff
    hi  Define          guifg=#ffffff
    hi  Delimiter       guifg=#ffffff gui=bold
    hi  DiffAdd         guifg=#ffffff
    hi  DiffChange      guifg=#ffffff
    hi  DiffDelete      guifg=#ffffff
    hi  DiffText        guifg=#ffffff
    hi  Directory       guifg=#ffffff
    hi  EndOfBuffer     guifg=#ffffff
    hi  ErrorMsg        guifg=#ffffff
    hi  Exception       guifg=#9d0006
    hi  Float           guifg=#458588 gui=bold
    hi  Number          guifg=#458588 gui=bold
    hi  FoldColumn      guifg=#ffffff
    hi  Folded          guifg=#ffffff
    hi  Function        guifg=#98971a
    hi  Identifier      guifg=#98971a
    hi  Ignore          guifg=#ffffff
    hi  IncSearch       guifg=#ffffff
    hi  Include         guifg=#98971a
    hi  Keyword         guifg=#d65d0e
    hi  Label           guifg=#cc241d
    hi  LineNr          guifg=#ffffff
    hi  Macro           guifg=#cc241d
    hi  MatchParen      guifg=#ffffff
    hi  ModeMsg         guifg=#ffffff
    hi  MoreMsg         guifg=#ffffff
    hi  MsgArea         guifg=#ffffff
    hi  MsgSeparator    guifg=#ffffff
    hi  NonText         guifg=#ffffff
    hi  Normal          guifg=#ffffff
    hi  NormalFloat     guifg=#ffffff
    hi  NormalNC        guifg=#ffffff
    hi  Operator        guifg=#d65d0e
    hi  Pmenu           guifg=#928374 guibg=#fbf1c7
    hi  PmenuSbar       guifg=#fbf1c7 guibg=none
    hi  PmenuSel        guifg=#fbf1c7 guibg=#b16286
    hi  PmenuThumb      guifg=none    guibg=none
    hi  PreCondit       guifg=#ffffff
    hi  PreProc         guifg=#ffffff
    hi  Question        guifg=#ffffff
    hi  QuickFixLine    guifg=#ffffff
    hi  Repeat          guifg=#ffffff
    hi  Search          guifg=#ffffff
    hi  SignColumn      guibg=none
    hi  Special         guifg=#ffffff
    hi  SpecialChar     guifg=#aaaafa guibg=#1c1c1c
    hi  SpecialComment  guifg=#ffffff
    hi  SpecialKey      guifg=#ffffff
    hi  SpellBad        guifg=#cc241d
    hi  SpellCap        guifg=#d79921
    hi  SpellLocal      guifg=#458588
    hi  SpellRare       guifg=#b16286
    hi  Statement       guifg=#7c6f64
    hi  StatusLine      guifg=#a89984 guibg=none gui=none
    hi  StatusLineNC    guifg=#a89984 guibg=none gui=none
    hi  StorageClass    guifg=#ffffff
    hi  String          guifg=#666666 guibg=#333333 gui=italic
    hi  Error           guifg=#ffffff guibg=#9d0006
    hi  Structure       guifg=#076678
    hi  Substitute      guifg=#ffffff
    hi  TabLine         guifg=#ffffff
    hi  TabLineFill     guifg=#ffffff
    hi  TabLineSel      guifg=#ffffff
    hi  Tag             guifg=#ffffff
    hi  TermCursor      guifg=#ffffff
    hi  TermCursorNC    guifg=#ffffff
    hi  Title           guifg=#ffffff
    hi  Todo            guifg=#d79921 guibg=none gui=underline
    hi  Type            guifg=#b16286 gui=bold
    hi  Typedef         guifg=#ffffff
    hi  Underlined      guifg=#ffffff
    hi  VertSplit       guifg=#333333 guibg=none gui=none
    hi  Visual          guifg=none    guibg=#d5c4a1
    hi  VisualNC        guifg=#ffffff
    hi  WarningMsg      guifg=#ffffff
    hi  Whitespace      guifg=#ffffff
    hi  WildMenu        guifg=#ffffff
    hi  lCursor         guifg=#ffffff
      hi jsonKeyword      guifg=#ffffff

    hi  GitGutterAdd    guifg=#98971a
    hi  GitGutterChange guifg=#d79921
    hi  GitGutterDelete guifg=#458588

    hi  SyntasticErrorSign        guibg=none guifg=#d81735
    hi  SyntasticWarningSign      guibg=none guifg=#ffa800
    hi  SyntasticStyleErrorSign   guibg=none guifg=#d81735
    hi  SyntasticStyleWarningSign guibg=none guifg=#ffa800

    let g:limelight_conceal_guifg = '#333333'
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

vm <silent> f :'<,'>!fmt -w 80<CR>
vm <silent> t :Tabularize /\|<CR>

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
"au BufNewFile,BufRead * RainbowToggleOn
au BufNewFile,BufRead * Limelight
au BufNewFile,BufRead *.c,*.cs set expandtab!
au CursorHold * execute 'hi CursorLineNr guibg=#221d1f guifg=#30ff6a'
au InsertEnter * execute 'hi CursorLineNr guibg=#221d1f guifg=#ff9c30'
au InsertLeave * execute 'hi CursorLineNr guibg=#221d1f guifg=#000000'
au BufWrite * call CleanFile()
"au BufWritePost * silent !touch %
"au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc

call ToggleTheme()
