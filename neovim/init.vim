filetype indent plugin on
syntax on

"set cursorline
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
set listchars=tab:\▎\ ,extends:>
set magic
"set mat=1
"set matchpairs=
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
set updatetime=1000
set undodir=~/.config/nvim/tmp/undo/
set undofile
set whichwrap+=<,>,h,l
set wrap
"let g:python_host_prog='/run/current-system/profile/bin/python3'
"let g:deoplete#enable_at_startup = 1
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_zig_zls_executable = '/home/tau/bin/zls'
let g:ale_linters = { 'zig': ['zls'] }
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_sign_error = '▶ '
let g:ale_sign_warning = '▶ '
"let g:ale_hover_cursor = 1
"let g:ale_set_balloons = 1
"let g:ale_hover_to_preview = 1

function! CleanFile()
  normal mZ
  :%s/\s\+$//e
  normal `Z
endfunction

let g:gitgutter_sign_added = '▍ '
let g:gitgutter_sign_modified = '▍ '
let g:gitgutter_sign_removed = '▍ '
let g:gitgutter_sign_removed_first_line = '▍ '
let g:gitgutter_sign_modified_removed = '▍ '

" SEARCH ONLY
" nm hh <NOP>
" nm jj <NOP>
" nm kk <NOP>
" nm ll <NOP>
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
" ALE


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
nm <F8> :Limelight!!<CR>
nm <F9> :call ToggleTheme()<CR>

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
au BufNewFile,BufRead *.c,*.cs set expandtab
au BufNewFile,BufRead *.c,*.h set ft=c
au CursorHold,CursorHoldI * execute 'ALEHover'
"au InsertEnter * execute 'hi CursorLineNr guibg=#221d1f guifg=#ff9c30'
"au InsertLeave * execute 'hi CursorLineNr guibg=#221d1f guifg=#000000'
au BufWrite * call CleanFile()
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc

" Theme

au BufEnter *.py call matchadd('Comment', '^.*log.debug.*$')
au BufEnter *.py call matchadd('Comment', '^.*log.notice.*$')
au BufEnter *.py call matchadd('Comment', '^.*log.info.*$')
au BufEnter *.py call matchadd('Comment', '^.*log.warn.*$')
au BufEnter *.py call matchadd('Comment', '^.*log.err.*$')
au BufEnter *.py call matchadd('Comment', '^.*log.alert.*$')
au BufEnter *.py call matchadd('Comment', '^.*log.crit.*$')
au BufEnter *.py call matchadd('Comment', '^.*log.emerg.*$')
au BufEnter * call matchadd('Note', 'NOTE')
au BufEnter * call matchadd('Note', 'NOTE:')
au BufEnter * call matchadd('Todo', 'TODO:')
au BufEnter * call matchadd('Todo', 'TODO')

function! LightTheme()
  "hi ColorColumn     guibg=#ffffff
  "hi Conceal         guibg=#ffffff
  "hi Cursor          guibg=#ffffff
  hi CursorColumn    guibg=#c5c5c5
  hi CursorLine      guibg=#c5c5c5
  hi CursorLineNr    guibg=#111111
  hi DiffAdd         guibg=#111111
  hi DiffChange      guibg=#111111
  hi DiffDelete      guibg=#111111
  hi DiffText        guibg=#111111
  hi Directory       guibg=#111111
  hi EndOfBuffer     guifg=none gui=none
  hi ErrorMsg        guibg=#ff0000
  hi FoldColumn      guibg=#111111
  hi Folded          guibg=#111111
  hi IncSearch       guibg=#111111
  hi LineNr          guibg=#111111
  hi MatchParen      guibg=#111111
  hi ModeMsg         guibg=#111111
  hi MoreMsg         guibg=#111111
  hi MsgArea         guibg=#dddddd
  hi MsgSeparator    guibg=#111111
  hi NonText         guifg=none gui=none
  hi Normal          guibg=#dddddd guifg=#444444
  hi NormalFloat     guibg=#111111
  "hi NormalNC        guibg=#111111
  hi Pmenu           guibg=#dddddd
  hi PmenuSbar       guibg=#dddddd
  hi PmenuSel        guibg=#cccccc guifg=#000000
  hi PmenuThumb      guibg=#dddddd
  hi Question        guibg=#111111
  hi QuickFixLine    guibg=#eeeeee
  "hi RedrawDebugClear  guibg=#111111
  "hi RedrawDebugComposed  guibg=#111111
  "hi RedrawDebugNormal  guibg=#111111
  "hi RedrawDebugRecompose  guibg=#111111
  hi Search          guibg=#111111
  hi SignColumn      guibg=#dddddd
  hi SpecialKey      guibg=#111111
  hi SpellBad        guibg=#443333
  hi SpellCap        guibg=#444433
  hi SpellLocal      guibg=#333344
  hi SpellRare       guibg=#334444
  hi StatusLine      guibg=none gui=none guifg=#333333
  hi StatusLineNC    guibg=none gui=none guifg=#333333
  hi Substitute      guibg=#111111
  hi TabLine         guibg=#111111
  hi TabLineFill     guibg=#111111
  hi TabLineSel      guibg=#111111
  hi TermCursor      guibg=#111111
  hi TermCursorNC    guibg=#111111
  hi Title           guibg=#111111
  hi VertSplit       guibg=none guifg=#111111 gui=none
  hi Visual          guibg=#eeeeee
  hi VisualNC        guibg=#eeeeee
  hi WarningMsg      guibg=#111111
  hi Whitespace      guibg=#dddddd
  hi WildMenu        guibg=#111111
  hi lCursor         guibg=#111111

  hi Boolean guifg=#111111
  hi Character guifg=#111111
  hi Comment guifg=#666666
  hi Conditional guifg=#98971a gui=bold
  hi Constant guifg=#98971a
  hi Debug guifg=#666666
  hi Define guifg=#666666
  hi Error  guifg=#ff0000 guibg=none
  hi Exception guifg=#ff0000
  hi Float guifg=#111111
  hi Function guifg=#458588 gui=bold
  hi Ignore guifg=#666666
  hi Include guifg=#666666
  hi Keyword guifg=#000000 gui=bold
  hi Label guifg=#666666
  hi Macro guifg=#ff0000
  hi PreCondit guifg=#666666
  hi PreProc guifg=#666666
  hi Repeat guifg=#666666
  hi Special guifg=#666666
  hi SpecialComment guifg=#666666
  hi Statement guifg=#d79921
  hi StorageClass guifg=#000000 gui=bold
  hi String guibg=#b5b5b5 guifg=#777777 gui=italic
  hi Structure guifg=#458588 gui=bold
  hi Todo guibg=#458588 guifg=#ffffff gui=bold
  hi Typedef guifg=#666666
  hi Underlined guifg=#666666
  hi Type guifg=#458588
  hi Operator guifg=#458588 gui=bold
  hi Identifier guifg=#111111
  hi qfFileName guibg=none
  hi qfLineNr guibg=none
  let g:limelight_conceal_guifg='#bbbbbb'
endfunction

function! DarkTheme()
  "hi ColorColumn     guibg=#ffffff
  "hi Conceal         guibg=#ffffff
  "hi Cursor          guibg=#ffffff
  hi CursorColumn    guibg=#454545
  hi CursorLine      guibg=#454545
  hi CursorLineNr    guibg=#111111
  hi DiffAdd         guibg=#111111
  hi DiffChange      guibg=#111111
  hi DiffDelete      guibg=#111111
  hi DiffText        guibg=#111111
  hi Directory       guibg=#111111
  hi EndOfBuffer     guifg=#000000 gui=none guibg=#171a1b
  hi ErrorMsg        guibg=#ff0000
  hi FoldColumn      guibg=#000000
  hi Folded          guibg=#000000
  hi IncSearch       guibg=#000000
  hi LineNr          guibg=#000000
  hi MatchParen      guibg=#000000
  hi ModeMsg         guibg=#000000
  hi MoreMsg         guibg=#000000
  hi MsgArea         guibg=#1d2021
  hi MsgSeparator    guibg=#eeeeee
  hi NonText         guibg=none gui=none
  hi Normal          guibg=#1d2021 guifg=#eeeeee
  hi NormalFloat     guibg=#111111
  "hi NormalNC        guibg=#111111
  hi Pmenu           guibg=#444444
  hi PmenuSbar       guibg=#444444
  hi PmenuSel        guibg=#cccccc guifg=#000000
  hi PmenuThumb      guibg=#dddddd
  hi Question        guibg=#111111
  hi QuickFixLine    guibg=#111111
  "hi RedrawDebugClear  guibg=#111111
  "hi RedrawDebugComposed  guibg=#111111
  "hi RedrawDebugNormal  guibg=#111111
  "hi RedrawDebugRecompose  guibg=#111111
  hi Search          guibg=#eeeeee
  hi SignColumn      guibg=#1d2021
  hi SpecialKey      guibg=#eeeeee
  hi SpellBad        guibg=#443333
  hi SpellCap        guibg=#444433
  hi SpellLocal      guibg=#333344
  hi SpellRare       guibg=#334444
  hi StatusLine      guibg=none gui=bold guifg=#000000
  hi StatusLineNC    guibg=none gui=bold guifg=#000000
  hi Substitute      guibg=#111111
  hi TabLine         guibg=#111111
  hi TabLineFill     guibg=#111111
  hi TabLineSel      guibg=#111111
  hi TermCursor      guibg=#111111
  hi TermCursorNC    guibg=#111111
  hi Title           guibg=#111111
  hi VertSplit       guibg=none guifg=#111111 gui=none
  hi Visual          guifg=#333333 guibg=#171a1b
  hi VisualNC        guifg=#333333 guibg=#171a1b
  hi WarningMsg      guibg=#111111
  hi Whitespace      guibg=#1d2021 guibg=none
  hi WildMenu        guibg=#111111
  hi lCursor         guibg=#111111

  hi Boolean guifg=#eeeeee
  hi Character guifg=#eeeeee
  hi Comment guifg=#555555
  hi Conditional guifg=#98971a gui=bold
  hi Constant guifg=#98971a
  hi Debug guifg=#aaaaaa
  hi Define guifg=#aaaaaa
  hi Error  guifg=#ff0000 guibg=none
  hi Exception guifg=#ff0000
  hi Float guifg=#eeeeee
  hi Function guifg=#458588 gui=bold
  hi Ignore guifg=#aaaaaa
  hi Include guifg=#aaaaaa
  hi Keyword guifg=#ffffff gui=bold
  hi Label guifg=#aaaaaa
  hi Macro guifg=#ff0000
  hi PreCondit guifg=#aaaaaa
  hi PreProc guifg=#aaaaaa
  hi Repeat guifg=#aaaaaa
  hi Special guifg=#aaaaaa
  hi SpecialComment guifg=#aaaaaa
  hi Statement guifg=#d79921
  hi StorageClass guifg=#ffffff gui=bold
  hi String guibg=#222222 guifg=#aaaaaa gui=italic
  hi Structure guifg=#458588 gui=bold
  hi Todo guifg=#d79921 guibg=none gui=bold
  hi Note guifg=#d79921 gui=bold
  hi Typedef guifg=#aaaaaa
  hi Underlined guifg=#aaaaaa
  hi Type guifg=#458588
  hi Operator guifg=#458588 gui=bold
  hi Identifier guifg=#eeeeee
  hi qfFileName guibg=none
  hi qfLineNr guibg=none
  let g:limelight_conceal_guifg='#555555'
endfunction

function! BlackTheme()
  "hi ColorColumn     guibg=none
  "hi Conceal         guibg=none
  "hi Cursor          guibg=none
  hi CursorColumn    guibg=none
  hi CursorLine      guibg=none
  hi CursorLineNr    guibg=none
  hi DiffAdd         guibg=none
  hi DiffChange      guibg=none
  hi DiffDelete      guibg=none
  hi DiffText        guibg=none
  hi Directory       guibg=none
  hi EndOfBuffer     guifg=#000000 gui=none guibg=none
  hi ErrorMsg        guibg=none
  hi FoldColumn      guibg=none
  hi Folded          guibg=none
  hi IncSearch       guibg=none
  hi LineNr          guibg=none
  hi MatchParen      guibg=none
  hi ModeMsg         guibg=none
  hi MoreMsg         guibg=none
  hi MsgArea         guibg=none
  hi MsgSeparator    guibg=none
  hi NonText         guibg=none gui=none
  hi Normal          guibg=none guifg=none
  hi NormalFloat     guibg=none
  "hi NormalNC        guibg=none
  hi Pmenu           guibg=none
  hi PmenuSbar       guibg=none
  hi PmenuSel        guibg=none guifg=none
  hi PmenuThumb      guibg=none
  hi Question        guibg=none
  hi QuickFixLine    guibg=none
  "hi RedrawDebugClear  guibg=none
  "hi RedrawDebugComposed  guibg=none
  "hi RedrawDebugNormal  guibg=none
  "hi RedrawDebugRecompose  guibg=none
  hi Search          guibg=#f49b15
  hi SignColumn      guibg=none
  hi SpecialKey      guibg=none
  hi SpellBad        guibg=none
  hi SpellCap        guibg=none
  hi SpellLocal      guibg=none
  hi SpellRare       guibg=none
  hi StatusLine      guibg=none gui=bold guifg=none
  hi StatusLineNC    guibg=none gui=bold guifg=none
  hi Substitute      guibg=none
  hi TabLine         guibg=none
  hi TabLineFill     guibg=none
  hi TabLineSel      guibg=none
  hi TermCursor      guibg=none
  hi TermCursorNC    guibg=none
  hi Title           guibg=none
  hi VertSplit       guibg=none guifg=none gui=none
  hi Visual          guibg=#f49b15 guifg=#1d2021 gui=none
  hi VisualNC        guifg=none guibg=none
  hi WarningMsg      guibg=none
  hi Whitespace      guibg=none guibg=none
  hi WildMenu        guibg=none
  hi lCursor         guibg=none

  hi Boolean guifg=#f49b15
  hi Character guibg=none guifg=#777777 gui=italic,underline,bold
  hi Comment guifg=#555555
  hi Conditional guifg=#f49b15 gui=bold
  hi Constant guifg=none
  hi Debug guifg=none
  hi Define guifg=#f49b15
  hi Error  guifg=#ff0000 guibg=none
  hi Exception guifg=#f49b15
  hi Float guifg=#f49b15
  hi Number guifg=#f49b15
  hi Function guifg=#f49b15 gui=bold
  hi Ignore guifg=none
  hi Include guifg=none
  hi Keyword guifg=#f49b15 gui=bold
  hi Label guifg=#f49b15
  hi Macro guifg=none
  hi PreCondit guifg=none
  hi PreProc guifg=none
  hi Repeat guifg=#f49b15 gui=bold
  hi Special guibg=none guifg=#777777 gui=italic
  hi SpecialComment guifg=none
  hi Statement guifg=#f49b15
  hi StorageClass guifg=#f49b15 gui=bold
  hi String guibg=none guifg=#777777 gui=italic,underline,bold
  hi Structure guifg=#f49b15 gui=bold
  hi Todo guibg=none guifg=none gui=bold
  hi Typedef guifg=none
  hi Underlined guifg=none
  hi Type guifg=#f49b15
  hi Operator guifg=#f49b15 gui=bold
  hi Identifier guifg=none
  hi qfFileName guibg=none
  hi qfLineNr guibg=none
  let g:limelight_conceal_guifg='#444444'

  let g:gitgutter_sign_added = '▶ '
  let g:gitgutter_sign_modified = '▪ '
  let g:gitgutter_sign_removed = '◀ '
  let g:gitgutter_sign_removed_first_line = '◀ '
  let g:gitgutter_sign_modified_removed = '▪ '

  hi GitGutterAdd guifg=#f49b15 gui=italic
  hi GitGutterChange guifg=#f49b15
  hi GitGutterDelete guifg=#f49b15
endfunction


let g:theme_toggle = 1
function! ToggleTheme()
  if (g:theme_toggle == 0)
    call DarkTheme()
    let g:theme_toggle = 1
  elseif (g:theme_toggle == 1)
    call LightTheme()
    let g:theme_toggle = 2
  else
    call BlackTheme()
    let g:theme_toggle = 0
  endif
endfunction

hi SpellCap guibg=none guifg=#ff0000 gui=none
hi SpellBad guibg=none guifg=#ff0000 gui=none
hi SpellLocal guibg=none guifg=#ff0000 gui=none
hi SpellRare guibg=none guifg=#ff0000 gui=none

hi GitGutterAdd guifg=#98971a
hi GitGutterChange guifg=#458588
hi GitGutterDelete guifg=#cc241d


call DarkTheme()
