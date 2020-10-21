" note: a lot of defaults come from sensible.vim
" it's good, install it!

" to install Vundle:
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" then open vim and run :PluginInstall

" might be smart to crib more stuff from tpope's vimrc:
" https://github.com/tpope/tpope/blob/master/.vimrc

set nocompatible " be iMproved, required by Vundle

filetype off     " required by Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/base16-vim'
Plugin 'fatih/vim-go' " install with :GoInstallBinaries
Plugin 'godlygeek/tabular'
Plugin 'google/vim-jsonnet'
Plugin 'hashivim/vim-terraform'
Plugin 'psf/black'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdtree-git-plugin'
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-ruby/vim-ruby'
"Plugin 'scrooloose/syntastic'
call vundle#end()
filetype plugin indent on " required by Vundle

" auto-run goimports (and gofmt) on save
let g:go_fmt_command = "goimports"

" map spacebar as the leader key
let mapleader = "\<Space>"

setglobal pastetoggle=<F2>

" use :help 'option' to see the documentation for the given option
set ruler
set number
set backspace=2
"set tabstop=4
set tags=tags;~/
augroup filetype
  au! BufRead,BufNewFile *.bash*        set filetype=sh
  au! BufRead,BufNewFile *.c,*.h,*.cpp  set foldmethod=syntax
  au! BufRead,BufNewFile *.py           set foldmethod=indent
augroup END
"au VimEnter * highlight clear SignColumn

syntax on
filetype plugin on
filetype indent on

function! Stab(value)
  let &shiftwidth  = a:value
  let &softtabstop = a:value
  let &tabstop     = a:value
endfunc

call Stab(4)

" disable that stupid window
map q: :q

" automatically jump to end of text you pasted
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

"CTRL-N for nerdtree
map <C-n> :NERDTreeToggle<CR>
" close vim if nerdtree is only window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" auto-open nerdtree
"autocmd vimenter * NERDTree

" open a NERDTree automatically when vim starts up if no files were specified
autocmd vimenter * if !argc() | NERDTree | endif

" airline settings
let g:airline#extensions#tabline#enabled = 1

" splitjoin
nmap <Leader>j :SplitjoinJoin<cr>
nmap <Leader>s :SplitjoinSplit<cr>

" buffers
noremap <leader>bl :ls<CR>      " List buffers.
noremap <leader>bn :bn<CR>      " Next buffer.
noremap <leader>bp :bp<CR>      " Previous buffer.
noremap <leader>bt :b#<CR>      " Toggle to most recently used buffer.
" these require butane.vim
noremap <leader>bd :Bclose<CR>  " Close the buffer.
noremap <leader>bx :Bclose!<CR> " Close the buffer & discard changes.

" railscasts color scheme
" to install:
"  $ git clone https://github.com/chrishunt/color-schemes.git
"  $ cd color-schemes
"  $ mkdir -p ~/.vim/colors
"  $ cp railscasts/base16-railscasts.vim ~/.vim/colors/
set background=dark
colorscheme base16-railscasts

highlight clear SignColumn
highlight VertSplit    ctermbg=236
highlight ColorColumn  ctermbg=237
" highlight LineNr       ctermbg=236 ctermfg=240 " old
highlight LineNr       ctermbg=240 ctermfg=12
highlight CursorLineNr ctermbg=236 ctermfg=240
highlight CursorLine   ctermbg=236
highlight StatusLineNC ctermbg=238 ctermfg=0
highlight StatusLine   ctermbg=240 ctermfg=12
highlight IncSearch    ctermbg=0   ctermfg=3
highlight Search       ctermbg=0   ctermfg=9
highlight Visual       ctermbg=3   ctermfg=0
highlight Pmenu        ctermbg=240 ctermfg=12
highlight PmenuSel     ctermbg=0   ctermfg=3
highlight SpellBad     ctermbg=0   ctermfg=1
" end railscasts color scheme

" bind decrement number to ctrl-shift-a
"FIXME: doesn't work
"nnoremap <C-S-a> <C-x>

" the following are for Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" the following is fore vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" for powerline
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" to debug youcompleteme
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

" vim-go settings
" these are syntax highlighting options for vim-go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
" run the linters on autosave
let g:go_metalinter_autosave = 1
" I took out golint, add it back?
" let g:go_metalinter_autosave_enabled = ['vet', 'errcheck']
" this could be useful with :GoBuild but are there more implications?
"set autowrite

" black settings
" run black against python scripts on save
autocmd BufWritePre *.py execute ':Black'
" ignore differences in strings
let g:black_skip_string_normalization=1

" vim-terraform settings
" auto-align settings
let g:terraform_align=1
" run terraform fmt on save
let g:terraform_fmt_on_save=1

if exists('+undofile')
  set undofile
endif

" if v:version >= 700
"   " not 100% sure what this does
"   setglobal viminfo=!,'20,<50,s10,h
" endif
if !empty($SUDO_USER) && $USER !=# $SUDO_USER
  setglobal viminfo=
  setglobal directory-=~/tmp
  setglobal backupdir-=~/tmp
elseif exists('+undofile')
  setglobal undodir=~/.cache/vim/undo
  if !isdirectory(&undodir)
    call mkdir(&undodir, 'p')
  endif
endif
