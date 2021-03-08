"NERDTree
"map <C-n> :NERDTreeToggle<CR>
"map <C-i> :NERDTreeFind<CR>
"let g:NERDTreePatternMatchHighlightFullName = 1
"let NERDTreeAutoDeleteBuffer = 1
""let NERDTreeMinimalUI = 1
"let NERDTreeDirArrows = 1
"let g:NERDDefaultAlign = 'left'
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
"let g:NERDTreeChDirMode=2
""let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__', 'node_modules']
"let g:NERDTreeShowBookmarks=1
"let NERDTreeShowHidden=1

"Theme 
syntax enable
set background=dark
highlight Normal ctermbg=None
" colorscheme gruvbox
" let g:airline_theme='gruvbox'
colorscheme ayu
set termguicolors

" bbye
:nnoremap <Leader>q :Bdelete<CR>

" rnvimr ranger popup
" tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
nnoremap <silent> <Leader>o :RnvimrToggle<CR>
" tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>
" Make Ranger replace netrw and be the file explorer
let g:rnvimr_ex_enable = 1
let g:NERDTreeHijackNetrw = 0
" Map Rnvimr action
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }
" fzf
nnoremap <silent> <leader>f :Rg<cr>
nnoremap <silent> <leader>F :Files<cr>

" numbers
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>

" bookmark - fix for quickfix window
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

" auto cwd
let g:autocwd_patternwd_pairs = [
	\['*', '*REPO*'],
\]
