set nocompatible
set noerrorbells

set nopaste
set pastetoggle=<F10>

map e <Nop>
let mapleader="e"
" esc
noremap <Leader>e <Esc>
inoremap jk <Esc>
" Ctrl-V
noremap <C-p> <C-v>
cnoremap <C-p> <C-v>
inoremap <C-p> <C-v>
noremap <Leader>v <C-v>
" complete
inoremap <C-i> <C-y>
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>
" file edit
noremap fw :wq<Enter>
inoremap fw <Esc>:wq<Enter>
noremap fq :q<Enter>
inoremap fq <Esc>:q<Enter>
" edit
noremap <Leader>r <C-r>
noremap U :redo<Enter>
" window
nnoremap sv :vsplit 
nnoremap sh :split 
nnoremap sf :sfind 
nnoremap wn <C-w>w
nnoremap wp <C-w>W
nnoremap wj <C-w>j
nnoremap wk <C-w>k
nnoremap wh <C-w>h
nnoremap wl <C-w>l
nnoremap wmn <C-w>r
nnoremap wmp <C-w>R
" tabpage
nnoremap st :tabnew 
nnoremap tq :tabclose<Enter>
nnoremap tn :+tabnext<Enter>
nnoremap tp :-tabnext<Enter>
nnoremap tmn :+tabmove<Enter>
nnoremap tmp :-tabmove<Enter>

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
"set ignorecase
set hlsearch
set incsearch
set showmatch
set nowrap
set nowrapscan
set mouse=a
set selection=exclusive
set selectmode=mouse,key
set showmode
set showcmd
set cmdheight=2
set encoding=utf-8
"set textwidth=80
"set colorcolumn=80
" show highlight, use: hi
set cursorline
hi CursorLine term=underline cterm=underline ctermbg=NONE ctermfg=NONE gui=underline guibg=NONE guifg=NONE
"set cursorcolumn
"hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=whit
set scrolloff=5
set sidescroll=20
set sidescrolloff=5
"set scrollfocus
set undofile
set undodir=~/.vim/undo/
set wildmenu
set wildmode=list:longest
set completeopt=menuone,preview  "code completion
set magic
"set list  "show tab and enter
set prompt
set pumheight=15
set splitbelow
set splitright


" vim plugged
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" alignment plug
Plug 'godlygeek/tabular', {'for': ['c', 'cpp', 'cs', 'css', 'go', 'javascript', 'html/xhtml', 'make', 'lua', 'php', 'plsql', 'perl', 'objc', 'proto', 'r', 'ruby', 'scala', 'sql', 'tex', 'yaml', 'java', 'python', 'sh', 'vim', 'markdown']}

" lsp (language server protocol)
" coc.nvim: https://github.com/neoclide/coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


" coc.nvim conf
"let g:coc_node_path = '~/.local/node-16.13.0/bin/node'
let g:coc_config_home = '~/.config/vim'

