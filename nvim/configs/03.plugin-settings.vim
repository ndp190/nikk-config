" lsp
" nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gd <cmd>Telescope lsp_definitions<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> gD <cmd>lua require('telescope.builtin').lsp_declaration()<cr>
" nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gr <cmd>lua require('telescope.builtin').lsp_references({ on_complete = { function() vim.cmd"stopinsert" end } })<cr>
nnoremap <silent> gR <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gp <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> gn <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> gf <cmd>lua vim.lsp.buf.formatting()<CR>
vnoremap <silent> gf <cmd>lua vim.lsp.buf.range_formatting()<CR>
nnoremap <silent> gm <cmd>:exec ":setf " .input("set language: ")<CR>
" autoformat
" autocmd BufWritePre *.php lua vim.lsp.buf.formatting_sync(nil, 100)

" tmux
" set-option -sg escape-time 10
" set-option -g focus-events on
" set-option -sa terminal-overrides ',xterm-256color:RGB'

" Vim multicursor
let g:VM_maps = {}
let g:VM_maps['Find Under'] = '<C-g>' " normal mode multicursor
let g:VM_maps['Find Subword Under'] = '<C-g>' " visual mode multicursor


" Easy align - normally use for assignment format
vnoremap <silent> =1 :EasyAlign 1=<CR>

" telescope
nnoremap <leader>p <cmd>Telescope find_files<cr>
nnoremap <leader>P <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>f <cmd>Telescope lsp_document_symbols ignore_symbols=namespace,class,constant,variable,property,function<cr>
nnoremap <leader>F <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
" nnoremap <silent>fh <cmd>Telescope help_tags<cr>
" nnoremap <silent>ff <cmd>Telescope lsp_document_symbols default_text=:method:<cr>

" quickfix preview
let g:quickr_preview_keymaps = 0 " disable default quickr keymap
let g:quickr_preview_position = 'right'
let g:quickr_preview_on_cursor = 1

"" change behaviour when press enter on popup
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"" Theme
syntax enable
set background=dark
highlight Normal ctermbg=None

" gruvbox theme
colorscheme gruvbox
let g:airline_theme='gruvbox'
" ayu theme
" colorscheme ayu

" set termguicolors
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

" close-buffers
" :nnoremap <Leader>w :Bdelete this<CR>
" :nnoremap <Leader>W :Bdelete! this<CR>
:nnoremap <Leader>w :bp<BAR>bd#<CR>
:nnoremap <Leader>W :bp<BAR>bd!#<CR>

" numbers
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>

" Treeview
" nnoremap <silent>tt :NvimTreeToggle<CR>
" nnoremap <silent>tr :NvimTreeRefresh<CR>
" nnoremap <silent>tv :NvimTreeFindFile<CR>
" let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
" let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
" let g:nvim_tree_hide_dotfiles = 1 "0 by default, this option hides files and folders starting with a dot `.`
nnoremap <silent> tt :NERDTreeToggle<CR>
nnoremap <silent> tv :NERDTreeFind<CR>
let NERDTreeQuitOnOpen = 0
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeChDirMode = 2
let NERDTreeShowHidden = 1
autocmd BufEnter * silent! call SetProjectDirectory()

" Splitting window
noremap <C-w>x :split<cr>
noremap <C-w>v :vsplit<cr>

" bookmark
let g:bookmark_auto_close = 1
let g:bookmark_auto_save = 1
let g:bookmark_no_default_key_mappings = 1
let g:bookmark_manage_per_buffer = 0
nmap <silent>Mm <Plug>BookmarkToggle
nmap <silent>Mi <Plug>BookmarkAnnotate
nmap <silent>Mn <Plug>BookmarkNext
nmap <silent>Mp <Plug>BookmarkPrev
nmap <silent>Mc <Plug>BookmarkClear
nmap <silent>Mx <Plug>BookmarkClearAll
" nmap <silent>ma <Plug>BookmarkShowAll
" nmap <silent>ma <Plug>BookmarkMoveUp
" nmap <silent>ma <Plug>BookmarkMoveDown
" nmap <silent>ma <Plug>BookmarkMoveToLine
" nmap <silent>ma <cmd>Telescope vim_bookmarks all<cr>
nmap <silent>Ma <cmd>lua require('telescope').extensions.vim_bookmarks.all({ on_complete = { function() vim.cmd"stopinsert" end } })<cr>

" quickfix close after select
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

" " auto cwd
" let g:autocwd_patternwd_pairs = [
" 	\['*', '*REPO*'],
" \]

" git
nmap <leader>gh :diffget //3<CR>
nmap <leader>gh :diffget //2<CR>
nmap <leader>gs :G<CR>

" Press CR to import
inoremap <silent><expr> <CR> compe#confirm('<CR>')

" ToggleTerm
" By applying the mappings this way you can pass a count to your
" mapping to open a specific window.
" For example: 2<C-t> will open terminal 2
" nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
" inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

lua << EOF
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
      "intelephense",
      "tsserver",
      "quick_lint_js",
    },
    automatic_installation = true,
})

-- install language server
require'lspconfig'.gopls.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.phan.setup{}
require'lspconfig'.terraformls.setup{}

-- store intelephense license key at HOME/intelephense/licence.txt (no I am not spelling it wrong)
require'lspconfig'.intelephense.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.quick_lint_js.setup{}

require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminal
  -- size = 20 | function(term)
  --   if term.direction == "horizontal" then
  --     return 15
  --   elseif term.direction == "vertical" then
  --     return vim.o.columns * 0.4
  --   end
  -- end,
  size = function(term)
     if term.direction == "horizontal" then
       return 20 
     elseif term.direction == "vertical" then
       return vim.o.columns * 0.4
     end
   end,
  open_mapping = [[<c-t>]],
  -- on_open = fun(t: Terminal), -- function to run when the terminal opens
  -- on_close = fun(t: Terminal), -- function to run when the terminal closes
  -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
  -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
  -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  -- highlights = {
  --   -- highlights which map to a highlight group name and a table of it's values
  --   -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
  --   Normal = {
  --     guibg = <VALUE-HERE>,
  --   },
  --   NormalFloat = {
  --     link = 'Normal'
  --   },
  --   FloatBorder = {
  --     guifg = <VALUE-HERE>,
  --     guibg = <VALUE-HERE>,
  --   },
  -- },
  shade_terminals = false,
  -- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  direction = 'float',
  -- direction = 'vertical' | 'horizontal' | 'tab' | 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  -- float_opts = {
  --   -- The border key is *almost* the same as 'nvim_open_win'
  --   -- see :h nvim_open_win for details on borders however
  --   -- the 'curved' border is a custom border type
  --   -- not natively supported but implemented in this plugin.
  --   border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
  --   width = <value>,
  --   height = <value>,
  --   winblend = 3,
  -- }
}

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

----------------------
-- TELESCOPE CONFIG --
----------------------
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--no-ignore',
      '--hidden',
    },
    prompt_prefix = "🙈 ",
    selection_caret = "🐒 ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {"dist/.*", "node_modules/.*", "vendor/.*", "packages/.*", ".git/", ".gitignore", ".gitkeep", ".next", "package-lock.json"},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  },
  pickers = {
    live_grep = {
      additional_args = function(opts)
        return {"--hidden"}
      end
    },
    find_files = {
      find_command = {
        'rg',
        '--ignore',
        '--files',
        '--hidden',
      },
    },
  }
}

require('telescope').load_extension('vim_bookmarks')
local bookmark_actions = require('telescope').extensions.vim_bookmarks.actions
require('telescope').extensions.vim_bookmarks.all {
    attach_mappings = function(_, map) 
        map('n', 'dd', bookmark_actions.delete_selected_or_at_cursor)

        return true
    end
}

EOF

