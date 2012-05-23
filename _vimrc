call pathogen#infect()

" Don't be compatible with vi
set nocompatible

" change the leader key
let mapleader=","

" syntax highlighting
syntax on

filetype on
filetype plugin indent on
set number
set numberwidth=1
set background=dark
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
set laststatus=2            " Always show statusline, even if only 1 window.
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}

set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch

set noautowrite
set noautowriteall
set noautoread

set confirm
set showcmd
set report=0

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>

set colorcolumn=79
set guifont=Monospace\ 11

if has("gui_running")
    colorscheme desert
    set guioptions-=m
    
    set guioptions-=T
else
    colorscheme torte
endif

" Paste from clipboard
map <leader>p "+p
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>

" hide matches
nnoremap <leader><space> :nohlsearch<cr>

" Remove trailing whitespace
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" Templates to HTML
autocmd BufNewFile,BufRead *.mako,*.mak,*.jinja2 setlocal ft=html
autocmd FileType html,xhtml,xml,css setlocal expandtab shiftwidth=2 tabstop=2

map <leader>n :NERDTreeToggle<CR>
" autocmd vimenter * NERDTree
" autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let g:acp_behaviorPythonOmniLength = -1 
let g:acp_completeoptPreview = 1

map <leader>f :FufFile **/<CR>

map <leader>t :TlistToggle<CR>
let Tlist_Use_Right_Window = 0
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Use_Horiz_Window = 0
