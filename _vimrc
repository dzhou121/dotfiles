call pathogen#infect()

" Don't be compatible with vi
set nocompatible

" change the leader key
let mapleader=","

" syntax highlighting
syntax on

filetype on
filetype plugin indent on
set relativenumber
set numberwidth=1
set title
set wildmenu
set wildmode=full

set completeopt=menuone,longest,preview
set pumheight=6

au FileType python set omnifunc=pythoncomplete#Complete
au FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent

set cursorline
set scrolloff=3
set backspace=2
set ruler
set nowrap
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set ttyfast
set undofile
set laststatus=2            " Always show statusline, even if only 1 window.
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}

nnoremap / /\V
vnoremap / /\V
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
set showmatch

set noautowrite
set noautowriteall
set noautoread

set confirm
set showcmd
set report=0

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,eol:¬,trail:-,precedes:<,extends:>

autocmd BufNewFile,BufRead *.py setlocal colorcolumn=79
set guifont=Inconsolata\ 10
set linespace=2

if has("gui_running")
    set guioptions-=m
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=b
    set lines=999 columns=999
endif

set background=dark
colorscheme solarized
call togglebg#map("<F5>")

" Paste from clipboard
map <A-p> "+p
map <A-y> "+yy
nnoremap <A-q> :q<CR>
nnoremap <A-w> :w<CR>

" hide matches
nnoremap <leader><space> :nohlsearch<cr>

" Remove trailing whitespace
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" Templates to HTML
autocmd BufNewFile,BufRead *.mako,*.mak,*.jinja2 setlocal ft=html
autocmd BufNewFile,BufRead *.yml setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType html,xhtml,xml,css,yml setlocal expandtab shiftwidth=2 tabstop=2

map <leader>n :NERDTreeToggle<CR>
" autocmd vimenter * NERDTree
" autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


let g:acp_behaviorPythonOmniLength = -1 
let g:acp_completeoptPreview = 1

map <A-f> :FufFile **/<CR>
map <A-b> :FufBuffer<CR>

map <leader>t :TlistToggle<CR>
let Tlist_Use_Right_Window = 0
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Use_Horiz_Window = 0

" Run pep8
let g:pep8_map='<A-8>'

set wrap
set textwidth=79
set wrapmargin=0
autocmd BufNewFile,BufRead * setlocal formatoptions+=cqt

nnoremap <leader>y V`]
nnoremap <leader>l :set list!<CR>

inoremap <A-j> <ESC>
nnoremap <A-v> <C-w>v
nnoremap <A-x> <C-w>x
nnoremap <A-.> <C-w>>
nnoremap <A-,> <C-w><
nnoremap <A-l> <C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k

" autocmd vimenter * vsplit
" autocmd vimenter * vsplit
" autocmd vimenter * 5 wincmd <
" autocmd vimenter * wincmd l

au FocusLost * :wa
