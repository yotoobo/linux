set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"Plugin
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}  "A parser for a condensed HTML format
Plugin 'Valloric/YouCompleteMe' "A code-completion engine for Vim
Plugin 'davidhalter/jedi' "Awesome autocompletion library for python
Plugin 'scrooloose/syntastic' "Syntax checking hacks for vim
Plugin 'scrooloose/nerdtree'
Plugin 'Lokaltog/vim-powerline' "The ultimate vim statusline utility
Plugin 'vim-scripts/peaksea' "colorscheme

call vundle#end()            " required
filetype plugin indent on    " required

"General
syntax on
set history=700
set nu
set ic
set nohlsearch
set incsearch
set autoindent
set autowrite
set autoread
set ruler
set showcmd
set showmode
set showmatch
set ignorecase
set nobackup
set noswapfile
set backspace=indent,eol,start
set wrap

"设置Tab键
set tabstop=4
set shiftwidth=4
set softtabstop=4

"设置utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

"加强状态栏
set laststatus=2
set t_Co=256
let g:Powline_symbols='fancy'

"标记当前行列
set cursorline
set cursorcolumn

"colorscheme
if ! has("gui_running")
    set t_Co=256
endif
" feel free to choose :set background=light for a different style
set background=dark
colors peaksea

"map
let mapleader = ','
let maplocalleader = "\\"
map <Leader>s :w<CR>
map <Leader>x :x<CR>
map <Leader>q :q!<CR>
map <leader>tn :tabnew<cr>
map! jj <esc>

imap <c-d> <esc>ddi 
imap <c-k> <up>
imap <c-j> <down>
imap <c-l> <right>
imap <c-h> <left>
