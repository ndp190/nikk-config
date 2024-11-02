" 
" 
" DO NOT CHANGED THIS FILE
" CHANGE THE CONFIG IN NIKK-CONFIG REPO AND RERUN THE INSTALL SCRIPT INSTEAD
"
"

" -------- VUNDLE -------- "
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

"Typescript for Vim
Plugin 'leafgarland/typescript-vim'

" CtrlP
Plugin 'kien/ctrlp.vim'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Auto launch vim NerdTree at vim startup
autocmd VimEnter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * execute "normal \<C-w>w"

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" ------ END VUNDLE ------ "


" editor settings
set backspace=indent,eol,start
" set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab smartindent autoindent
set hlsearch    " highlight all search results
set ignorecase  " do case insensitive search
set incsearch   " show incremental search results as you type
set number      " display line number
set noswapfile  " disable swap file
syntax on

" paste toggle in edit mode (F2) 
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" set yank default to clipboard
set clipboard=unnamed

" config cursor
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
