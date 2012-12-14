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

au FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent textwidth=79 colorcolumn=79

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

if has("gui_macvim")
    set macmeta
endif

set background=dark
colorscheme solarized
call togglebg#map("<F5>")

" Paste from clipboard
map <A-p> "+p
" copy to clipboard
map <A-y> "+yy
nnoremap <A-q> :q<CR>
nnoremap <A-w> :w<CR>

" hide matches
nnoremap <leader><space> :nohlsearch<cr>

" Remove trailing whitespace
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" Templates to HTML
autocmd BufNewFile,BufRead *.mako,*.mak,*.jinja2 setlocal ft=html
autocmd FileType html,xhtml,xml,css,yml setlocal expandtab shiftwidth=2 tabstop=2

map <A-n> :NERDTreeToggle<CR>
" autocmd vimenter * NERDTree
" autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


let g:acp_behaviorPythonOmniLength = -1 
let g:acp_completeoptPreview = 1

" FuzzyFinder
map <A-f> :FufFile **/<CR>
map <A-c> :FufBuffer ;<CR>
map <A-t> :TlistToggle<CR>
let Tlist_Use_Right_Window = 0
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 0
let Tlist_Use_Horiz_Window = 0
let Tlist_File_Fold_Auto_Close = 0
let Tlist_WinWidth = 50
"let Tlist_Auto_Open = 1
"let Tlist_Show_One_File = 1
let g:fuf_file_exclude = '\.pyc$'
autocmd vimenter * TlistToggle

" Run pep8
let g:pep8_map='<A-8>'

set wrap
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

" set tags path
set tags=./tags,tags,~/tags

" au FocusLost * :wa

" jedi-vim 
let g:jedi#show_function_definition = 1
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#goto_command = "<C-n>"
"let ropevim_guess_project=1
"let ropevim_vim_completion=1
"let ropevim_enable_autoimport=1
"nnoremap <C-n> :call RopeGotoDefinition()<CR>

" folding
set foldmethod=indent
set foldtext=CustomFoldText()
"set foldtext=''
hi Folded term=NONE cterm=NONE gui=NONE guibg=NONE guisp=NONE ctermfg=NONE ctermbg=NONE
nnoremap <space> za
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

fu! CustomFoldText()
     "get first non-blank line
     let fs = v:foldstart
     while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
     endwhile
     if fs > v:foldend
         let line = getline(v:foldstart)
     else
         let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
     endif
 
     let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
     let foldSize = 1 + v:foldend - v:foldstart
     let foldSizeStr = " " . foldSize . " lines "
     let foldLevelStr = repeat("+--", v:foldlevel)
     let lineCount = line("$")
     let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
     let expansionString = repeat("-", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
     return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf
