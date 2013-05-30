set ruler
set nu
set bs=2
"set tabstop=4"
set tags=tags;~/
colorscheme peachpuff
augroup filetype
    au! BufRead,BufNewFile *.bash*          set filetype=sh
    au! BufRead,BufNewFile *.pde            set filetype=c
    au! BufRead,BufNewFile *.thtml          set filetype=php
    au! BufRead,BufNewFile *.jobdesc        set filetype=php
    au! BufRead,BufNewFile *.verilog,*.v    set filetype=verilog
    au! BufRead,BufNewFile *.verilog,*.v    set foldmethod=indent
    au! BufRead,BufNewFile *.c,*.h,*.cpp    set foldmethod=syntax
    au! BufRead,BufNewFile *.py             set foldmethod=indent
augroup END
syntax on
filetype plugin on
filetype indent on
function ToggleHLSearch()
    if &hls
        set nohls
    else
        set hls
    endif
endfunction

function! Stab(value)
    let &shiftwidth  = a:value
    let &softtabstop = a:value
    let &tabstop     = a:value
endfunc

call Stab(4)

function SetICSCode()
    set expandtab
    set smarttab
endfunction

call SetICSCode()

nmap <silent> <C-n> <Esc>:call ToggleHLSearch()<CR>.
let Tlist_Ctags_Cmd = "/opt/local/bin/ctags"
let Tlist_WinWidth = 50
map <Leader>1 :TlistToggle<cr>
map <Leader>2 :!/opt/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <Leader>0 :w\|verbose !ngspice -b %<CR>

map <Leader>9 :cn<cr>
map <Leader>8 :cp<cr>