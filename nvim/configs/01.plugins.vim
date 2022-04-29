call plug#begin('~/.config/nvim/bundle')
" Plugins has to sit between plug#begin & plug#end
" run `:so %` to reload and `:PlugInstall` to install plugins
" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'https://github.com/tom-anders/telescope-vim-bookmarks.nvim' " integrate vim-bookmarks to telescope
" theme
Plug 'morhetz/gruvbox' " theme
" Plug 'ayu-theme/ayu-vim' " ayu theme
Plug 'vim-airline/vim-airline' " status line
" " Highlight when using f to find word(s)
" Plug 'unblevable/quick-scope'
" " Auto pairs for '(' '[' '{'
" Plug 'jiangmiao/auto-pairs'
" Closetags
Plug 'alvan/vim-closetag'
" Better Comments - type `gcc`
Plug 'tpope/vim-commentary'
" Code format
" Plug 'beanworks/vim-phpfmt'
Plug 'junegunn/vim-easy-align'
" Ranger in popup
" Plug 'kevinhwang91/rnvimr'

" Treeview
Plug 'scrooloose/nerdtree'

" Intuitive buffer closing - type space-q
Plug 'moll/vim-bbye'
" " Smooth scroll
" Plug 'psliwka/vim-smoothie'
" Scrollbar
Plug 'gcavallanti/vim-noscrollbar'
Plug 'ompugao/vim-airline-noscrollbar'
" Intellisense
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall' " https://github.com/kabouzeid/nvim-lspinstall
Plug 'hrsh7th/nvim-compe' " auto complete
" Code highlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Quickfix preview pane (usually use when find code references)
Plug 'ronakg/quickr-preview.vim'
 " Jump to definition - <leader>j
Plug 'pechorin/any-jump.vim'
" auto set indent settings
Plug 'tpope/vim-sleuth'
" " :Autoformat or <F5>
" Plug 'chiel92/vim-autoformat'

" disable indent to use indentation configuration from 02.settings.vim
" set it here because it need to be set before loading vim-polyglot
let g:polyglot_disabled = ['autoindent'] 
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
" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" " Auto change working directory (to root git dir)
" Plug 'yssl/AutoCWD.vim'
" Ctrl + h/j/k/l to move between panel
Plug 'christoomey/vim-tmux-navigator'
" :Far foo bar **/*.py
" :Fardo
Plug 'brooth/far.vim'
" VimTeX for LateX
Plug 'lervag/vimtex'
" Multiple cursor
"" <c-n>to select next | \\A to select all
Plug 'mg979/vim-visual-multi' 
" Autojump (zsh) vim integration
Plug 'padde/jump.vim'
" Toggle full screen
" <c-w>o to toggle maximize
Plug 'troydm/zoomwintab.vim'
call plug#end()
