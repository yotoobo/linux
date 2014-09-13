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
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'Lokaltog/vim-powerline'

call vundle#end()            " required
filetype plugin indent on    " required

"General
syntax on
set nocompatible
set history=700
set nu
set hlsearch
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

"实现当前行列
set cursorline
set cursorcolumn
