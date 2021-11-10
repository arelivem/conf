set nocompatible

set nopaste
set pastetoggle=<F10>

let mapleader="e"
noremap <Leader>e <ESC>
cnoremap <Leader>e <ESC>
inoremap jk <ESC>
inoremap <Leader>; <ESC>:
noremap <Leader>v <C-V>
noremap <Leader>r <C-R>
noremap fw :wq<CR>
inoremap fw <ESC>:wq<CR>
noremap fq :q<CR>
inoremap fq <ESC>:q<CR>

set laststatus=2
if &term=~"xterm"
    if has("terminfo")
        set t_Co=8
        set t_Sf=[3%p1%dm
        set t_Sb=[4%p1%dm
    else
        set t_Co=8
        set t_Sf=[3%dm
        set t_Sb=[4%dm
    endif
endif

set statusline=
set statusline+=%1*\[%n]                                       "buffernr
set statusline+=%2*\ %<%f\                                     "File+path
set statusline+=%3*\ %=\ [%{''.(&fenc!=''?&fenc:&enc).''}]\    "Encoding
set statusline+=%4*\ %{(&bomb?\",BOM\":\"\")}\                 "Encoding2
set statusline+=%5*\ [%{&ff}]\                                 "FileFormat (dos/unix..)
set statusline+=%1*\ %=\ row:%6*%l/%L\ %1*col:%6*%002c\        "Rownumber/total (%)
set statusline+=%1*\ \ %m%r%w\ %P\ \                           "Modified? Readonly? Top/bot.
hi User1 cterm=bold ctermfg=0 ctermbg=7
hi User2 cterm=bold ctermfg=0 ctermbg=7
hi User3 cterm=bold ctermfg=0 ctermbg=7
hi User4 cterm=bold ctermfg=1 ctermbg=7
hi User5 cterm=bold ctermfg=0 ctermbg=7
hi User6 cterm=bold ctermfg=1 ctermbg=7

set autoread
set nobackup
set noswapfile
set noautowrite
set confirm
set clipboard=unnamed
syntax enable
filetype on
filetype plugin on
filetype indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set cindent
set autoindent
set smartindent
set number
set ruler
set noeb
"set ignorecase
set hlsearch
set incsearch
set showmatch
set nowrap
set nowrapscan
"set fillchars=vert:\ ,stl:\ ,stlnc:\
set mouse=a
set selection=exclusive
set selectmode=mouse,key
set showmode
set showcmd
set cmdheight=2
set encoding=utf-8
"set textwidth=80
"set colorcolumn=80
set scrolloff=5
set sidescroll=20
set sidescrolloff=5
set undofile
set undodir=~/.vim/undo/
set wildmenu
"set wildmode=longest:list,full
"set completeopt=preview,menu  "code completion
set magic
"set list  "show tab and enter


" vim plugged
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" alignment plug
Plug 'godlygeek/tabular', {'for': ['c', 'cpp', 'cs', 'css', 'go', 'javascript', 'html/xhtml', 'make', 'lua', 'php', 'plsql', 'perl', 'objc', 'proto', 'r', 'ruby', 'scala', 'sql', 'tex', 'yaml', 'java', 'python', 'sh', 'vim', 'markdown']}

" scala highlight
Plug 'derekwyatt/vim-scala', {'for': 'scala'}

call plug#end()