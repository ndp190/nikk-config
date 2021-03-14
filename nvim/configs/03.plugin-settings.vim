" coc
let g:coc_config_file='$HOME/.config/nvim/coc-settings.json'

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Theme
syntax enable
set background=dark
highlight Normal ctermbg=None
" colorscheme gruvbox
" let g:airline_theme='gruvbox'
colorscheme ayu
set termguicolors
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#fnametruncate = 32
let g:airline#extensions#tabline#fnamecollapse = 2
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#wordcount#filetypes = '\vasciidoc|help|mail|markdown|markdown.pandoc|org|rst|tex|text'
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
set laststatus=2    " enables vim-airline.

" bbye
:nnoremap <Leader>w :Bdelete<CR>
:nnoremap <Leader>W :Bdelete!<CR>

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
nnoremap <F5> :call ToggleDrawingMode()<CR>

" bookmark - fix for quickfix window
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

" auto cwd
let g:autocwd_patternwd_pairs = [
	\['*', '*REPO*'],
\]

" " SimpylFold
" let g:SimpylFold_fold_docstring=0
" let b:SimpylFold_fold_docstring=0
" let g:SimpylFold_docstring_preview=1

" Enable hidden file search for Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

function! ToggleDrawingMode()
	if &virtualedit ==# ""
		set virtualedit=all
		echo "Drawing mode"
	else
		set virtualedit=
		echo "Exit drawing mode"
	endif
endfunction
