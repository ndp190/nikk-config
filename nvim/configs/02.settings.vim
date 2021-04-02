let mapleader = "\<Space>" " prefix for triggering functions or events
filetype plugin on
filetype plugin indent on

" autocmd BufEnter * :set scroll=10 " set scroll line -> this sometime break
" coc find reference method
syntax on

set encoding=UTF-8
set mouse=a " enable mouse in neovim context

set incsearch 
set hlsearch " highlight text for search 

set tabstop=4
set softtabstop=0
set shiftwidth=4

" Enable switch buffer without saving modified contents
set hidden
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" key mapping
nnoremap <silent> <C-n> :bnext<CR>
nnoremap <silent> <C-p> :bprev<CR>

" map quit
nnoremap <leader>q :q<cr>

" save buffer
nnoremap <leader>s :w<cr>

" open empty buffer
nnoremap <leader>n :enew<cr>
