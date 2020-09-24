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
set autoread
set ignorecase
set laststatus=0
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
let g:python_host_prog='/run/current-system/profile/bin/python3.8'
let g:deoplete#enable_at_startup = 1
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1

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

let g:gitgutter_sign_added = '▍ '
let g:gitgutter_sign_modified = '▍ '
let g:gitgutter_sign_removed = '▍ '
let g:gitgutter_sign_removed_first_line = '▍ '
let g:gitgutter_sign_modified_removed = '▍ '

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

function! Vox()
  if mode()=="v"
      let [line_start, column_start] = getpos("v")[1:2]
      let [line_end, column_end] = getpos(".")[1:2]
  else
      let [line_start, column_start] = getpos("'<")[1:2]
      let [line_end, column_end] = getpos("'>")[1:2]
  end
  if (line2byte(line_start)+column_start) > (line2byte(line_end)+column_end)
      let [line_start, column_start, line_end, column_end] =
      \   [line_end, column_end, line_start, column_start]
  end
  let lines = getline(line_start, line_end)
  if len(lines) == 0
          return ''
  endif
  let lines[-1] = lines[-1][: column_end - 1]
  let lines[0] = lines[0][column_start - 1:]
  call writefile(lines, '/tmp/vimvox')
  call system('flite -voice "${HOME}/git/third/FliteVoices/eng-GBR-male;mycroft.flitevox" -f /tmp/vimvox &')
endfunction

function! VoxLine()
  call writefile([getline(line('.'))], '/tmp/vimvox')
  call system('flite -voice "${HOME}/git/third/FliteVoices/eng-GBR-male;mycroft.flitevox" -f /tmp/vimvox &')
endfunction

vm <silent> f :'<,'>!fmt -w 80<CR>
vm <silent> t :Tabularize /\|<CR>
vm <silent> z :'<,'>!zig fmt --stdin<CR>
vm <silent> ; :call Vox()<CR>

tno <Esc> <C-\><C-n>
tno <C-b><Esc> <Esc>

nm <F7> :RainbowToggle<CR>
nm <F8> :call LimelightToggle()<CR>
nm <F9> :call ToggleTheme()<CR>

nm <C-n> :tabnew<CR>

ino <Up> <NOP>
ino <Down> <NOP>
ino <Right> <NOP>
ino <Left> <NOP>

"nno <silent> k gk
"nno <silent> j gj
nno <silent> 0 g0
nno <silent> $ g$
ino <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#codeblocks#embeds#langs =
  \ [ "literatehaskell=lhaskell", "bash=sh", "zig", "elm", "scheme"
  \ , "c", "dot", "python",
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
"let g:rainbow_active = 1
let g:limelight_conceal_guifg='#444444'
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
" Toggle theme key-mappings.

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Stuff
au BufNewFile,BufRead * Limelight
au BufNewFile,BufRead *.c,*.cs set expandtab!
au CursorHold * execute 'hi CursorLineNr guibg=#221d1f guifg=#30ff6a'
au InsertEnter * execute 'hi CursorLineNr guibg=#221d1f guifg=#ff9c30'
au InsertLeave * execute 'hi CursorLineNr guibg=#221d1f guifg=#000000'
au BufWrite * call CleanFile()
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc

" Theme

"hi ColorColumn     guibg=#ffffff
"hi Conceal         guibg=#ffffff
"hi Cursor          guibg=#ffffff
hi CursorColumn    guibg=#ffffff
hi CursorLine      guibg=#222222
hi CursorLineNr    guibg=#ffffff
hi DiffAdd         guibg=#ffffff
hi DiffChange      guibg=#ffffff
hi DiffDelete      guibg=#ffffff
hi DiffText        guibg=#ffffff
hi Directory       guibg=#ffffff
hi EndOfBuffer     guibg=#000000
hi ErrorMsg        guibg=#ff0000
hi FoldColumn      guibg=#ffffff
hi Folded          guibg=#ffffff
hi IncSearch       guibg=#ffffff
hi LineNr          guibg=#ffffff
hi MatchParen      guibg=#ffffff
hi ModeMsg         guibg=#ffffff
hi MoreMsg         guibg=#ffffff
hi MsgArea         guibg=#000000
hi MsgSeparator    guibg=#ffffff
hi NonText         guibg=#000000
hi Normal          guibg=#000000
hi NormalFloat     guibg=#ffffff
"hi NormalNC        guibg=#ffffff
hi Pmenu           guibg=#111111
hi PmenuSbar       guibg=#111111
hi PmenuSel        guibg=#111111 guifg=#00ff00
hi PmenuThumb      guibg=#111111
hi Question        guibg=#ffffff
hi QuickFixLine    guibg=#000000
"hi RedrawDebugClear  guibg=#ffffff
"hi RedrawDebugComposed  guibg=#ffffff
"hi RedrawDebugNormal  guibg=#ffffff
"hi RedrawDebugRecompose  guibg=#ffffff
hi Search          guibg=#ffffff
hi SignColumn      guibg=#000000
hi SpecialKey      guibg=#ffffff
hi SpellBad        guibg=#443333
hi SpellCap        guibg=#444433
hi SpellLocal      guibg=#333344
hi SpellRare       guibg=#334444
hi StatusLine      guibg=#111111 gui=none guifg=#333333
hi StatusLineNC    guibg=#111111 gui=none guifg=#333333
hi Substitute      guibg=#ffffff
hi TabLine         guibg=#ffffff
hi TabLineFill     guibg=#ffffff
hi TabLineSel      guibg=#ffffff
hi TermCursor      guibg=#ffffff
hi TermCursorNC    guibg=#ffffff
hi Title           guibg=#111111
hi VertSplit       guibg=#111111 guifg=#111111
hi Visual          guibg=#222222
hi VisualNC        guibg=#222222
hi WarningMsg      guibg=#ffffff
hi Whitespace      guibg=#000000
hi WildMenu        guibg=#ffffff
hi lCursor         guibg=#ffffff

hi Boolean guifg=#eeeeee
hi Character guifg=#eeeeee
hi Comment guifg=#666666
hi Conditional guifg=#666666
hi Constant guifg=#eeeeee
hi Debug guifg=#666666
hi Define guifg=#666666
hi Error  guifg=#ff0000
hi Exception guifg=#ff0000
hi Float guifg=#eeeeee
hi Function guifg=#666666
hi Ignore guifg=#666666
hi Include guifg=#666666
hi Keyword guifg=#666666 gui=bold
hi Label guifg=#666666
hi Macro guifg=#ff0000
hi PreCondit guifg=#666666
hi PreProc guifg=#666666
hi Repeat guifg=#666666
hi Special guifg=#666666
hi SpecialComment guifg=#666666
hi Statement guifg=#666666
hi StorageClass guifg=#666666
hi String guibg=#333333 guifg=#ffffff gui=italic
hi Structure guifg=#666666
hi Todo guifg=#666666
hi Typedef guifg=#666666
hi Underlined guifg=#666666
hi Type guifg=#666666

hi GitGutterAdd guifg=#00ff00
hi GitGutterChange guifg=#ffff00
hi GitGutterDelete guifg=#ff0000
