let mapleader = "\<Space>" " prefix for triggering functions or events
filetype plugin on
filetype plugin indent on

" set regex engine to 'old' to improve performance
" set re=1
set re=0

set encoding=UTF-8
set mouse=a " enable mouse in neovim context

set tabstop=4
set softtabstop=0 expandtab " this affect tab or space character
set shiftwidth=4 smarttab
autocmd FileType php setl tabstop=4|setl shiftwidth=4|setl softtabstop=4
autocmd FileType python setl tabstop=4|setl shiftwidth=4|setl softtabstop=4
autocmd FileType html setl tabstop=2|setl shiftwidth=2|setl softtabstop=2
autocmd FileType javascript setl tabstop=2|setl shiftwidth=2|setl softtabstop=2
autocmd FileType typescript setl tabstop=2|setl shiftwidth=2|setl softtabstop=2
autocmd FileType typescriptreact setl tabstop=2|setl shiftwidth=2|setl softtabstop=2
autocmd FileType css setl tabstop=2|setl shiftwidth=2|setl softtabstop=2
autocmd Filetype ruby setlocal tabstop=2|setl shiftwidth=2|setl softtabstop=2

" Enable switch buffer without saving modified contents
set hidden
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
" set updatetime=300

" key mapping
nnoremap <silent> <C-n> :bnext<CR>
nnoremap <silent> <C-p> :bprev<CR>

" map quit
nnoremap <leader>q :q<cr>

" save buffer
nnoremap <leader>s :w<cr>

" open empty buffer
nnoremap <leader>n :enew<cr>

" visualize tab character
set list
set listchars=tab:▸·,trail:·

" let g:python3_host_prog = '/usr/bin/python3'
let g:python3_host_prog = '/opt/homebrew/bin/python3'

" detect astro file type
autocmd BufRead,BufNewFile *.astro set filetype=astro
