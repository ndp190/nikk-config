call plug#begin('~/.config/nvim/bundle')
" Plugins has to sit between plug#begin & plug#end
" run `:so %` to reload and `:PlugInstall` to install plugins
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'scrooloose/nerdtree'
" Plug 'morhetz/gruvbox' " theme
Plug 'ayu-theme/ayu-vim' " ayu theme
Plug 'vim-airline/vim-airline' " status line
" " Highlight when using f to find word(s)
" Plug 'unblevable/quick-scope'
" " Auto pairs for '(' '[' '{'
" Plug 'jiangmiao/auto-pairs'
" Closetags
Plug 'alvan/vim-closetag'
" Better Comments - type `gcc`
Plug 'tpope/vim-commentary'
" Ranger in popup
Plug 'kevinhwang91/rnvimr'
" Intuitive buffer closing - type space-q
Plug 'moll/vim-bbye'
" Smooth scroll
Plug 'psliwka/vim-smoothie'
" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}
 " Jump to definition - <leader>j
Plug 'pechorin/any-jump.vim'
" auto set indent settings
Plug 'tpope/vim-sleuth'
" Better Syntax Support
Plug 'sheerun/vim-polyglot'
" Line number display - F3 to toggle number, F4 to toggle on/off
Plug 'myusuf3/numbers.vim'
" Copy to clipboard - cp to copy, cv to paste, cP to copy current line
Plug 'christoomey/vim-system-copy'
" Jump to definition - <leader>j
" Plug 'pechorin/any-jump.vim'
" Start page
Plug 'mhinz/vim-startify'
" Bookmark - mm to toggle, mi to annotate, mn mp to navigate, ma to show all,
" mc to clear, mx to clear all
Plug 'MattesGroeger/vim-bookmarks'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'yssl/AutoCWD.vim'
" Drawing in vim
Plug 'gyim/vim-boxdraw'
call plug#end()
