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
set omnifunc=ale#completion#OmniFunc
let g:deoplete#enable_at_startup = 1
let g:ale_completion_enabled = 1
let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_underline=1
let g:gruvbox_undercurl=1
let g:gruvbox_improved_strings=1
let g:gruvbox_improved_warnings=1
let g:gruvbox_guisp_fallback='bg'
let g:gruvbox_number_column='none'
let g:lightline={}

let g:current_theme = 0
function ToggleTheme()
  if (g:current_theme == 1)
    let g:current_theme = 0
    set background=light
    let g:gruvbox_sign_column='bg0'
    let g:gruvbox_number_column='bg0'
  else
    let g:current_theme =1
    set background=dark
    let g:gruvbox_sign_column='bg0'
    let g:gruvbox_number_column='bg0'
  endif
endfunction

call ToggleTheme()
colorscheme gruvbox

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

vm <silent> f :'<,'>!fmt -w 80<CR>
vm <silent> t :Tabularize /\|<CR>

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
