if has("gui_macvim")
    set macmeta
    set gcr=n:blinkon0

    macmenu File.Close key=<nop>
    macmenu File.Save key=<nop>
    nnoremap <D-w> :q<CR>
    nnoremap <D-s> :w<CR>

    macmenu File.Print key=<nop>
    map <D-p> "+p
    map <D-y> "+yy

    inoremap <D-j> <ESC>
    macmenu Edit.Paste key=<nop>
    nnoremap <D-v> <C-w>v
    macmenu Edit.Cut key=<nop>
    nnoremap <D-x> <C-w>x
    nnoremap <D-.> <C-w>>
    nnoremap <D-,> <C-w><
    macmenu Tools.List\ Errors key=<nop>
    nnoremap <D-l> <C-w>l

    nnoremap <D-h> <C-w>h
    nnoremap <D-j> <C-w>j
    nnoremap <D-k> <C-w>k

    nnoremap <D-1> 1gt
    nnoremap <D-2> 2gt
    nnoremap <D-3> 3gt
    nnoremap <D-4> 4gt
    nnoremap <D-5> 5gt
endif
