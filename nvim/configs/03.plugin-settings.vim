" coc
" let g:coc_config_file='$HOME/.config/nvim/coc-settings.json'
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" lsp
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> ff <cmd>lua vim.lsp.buf.formatting()<CR>
" autoformat
" autocmd BufWritePre *.php lua vim.lsp.buf.formatting_sync(nil, 100)

"" auto import for ts
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>
"" Theme
syntax enable
set background=dark
highlight Normal ctermbg=None
" gruvbox theme
colorscheme gruvbox
let g:airline_theme='gruvbox'
" ayu theme
" colorscheme ayu

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
" nnoremap <F5> :CocCommand prettier.formatFile<CR>
" vmap <F5> <Plug>(coc-format-selected)
nnoremap <F6> :call ToggleDrawingMode()<CR>

" bookmark - fix for quickfix window
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
let g:bookmark_auto_close = 1
let g:bookmark_auto_save = 1

" auto cwd
let g:autocwd_patternwd_pairs = [
	\['*', '*REPO*'],
\]

" git
nmap <leader>gh :diffget //3<CR>
nmap <leader>gh :diffget //2<CR>
nmap <leader>gs :G<CR>

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

lua << EOF
require'lspinstall'.setup() -- important

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{
	-- settings = {
	--   rootMarkers = {".git/"},
	--   languages = {
	-- 	["="] = {misspell},
	-- 	vim = {vint},
	-- 	lua = {luafmt},
	-- 	go = {golint, goimports},
	-- 	python = {black, isort, flake8, mypy},
	-- 	typescript = {prettier, eslint},
	-- 	javascript = {prettier, eslint},
	-- 	typescriptreact = {prettier, eslint},
	-- 	javascriptreact = {prettier, eslint},
	-- 	yaml = {prettier},
	-- 	json = {prettier},
	-- 	html = {prettier},
	-- 	scss = {prettier},
	-- 	css = {prettier},
	-- 	markdown = {prettier},
	-- 	sh = {shellcheck},
	-- 	tf = {terraform}
	--   }
	-- }
  }
end

--------------------------
-- AUTO COMPLETE CONFIG --
--------------------------
vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
}
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF
