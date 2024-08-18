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
nnoremap <silent> gf <cmd>lua vim.lsp.buf.format({async=true})<CR>
vnoremap <silent> gf <cmd>lua vim.lsp.buf.range_formatting()<CR>
nnoremap <silent> gm <cmd>:exec ":setf " .input("set language: ")<CR>
nnoremap <silent> gA <cmd>CodeCompanionToggle<CR>
nnoremap <silent> gI <cmd>CodeCompanionActions<CR>
" autoformat
" autocmd BufWritePre *.php lua vim.lsp.buf.formatting_sync(nil, 100)

nnoremap <leader>l :noh<CR>

" tmux
" set-option -sg escape-time 10
" set-option -g focus-events on
" set-option -sa terminal-overrides ',xterm-256color:RGB'

" Vim multicursor
let g:VM_maps = {}
let g:VM_maps['Find Under'] = '<C-g>' " normal mode multicursor
let g:VM_maps['Find Subword Under'] = '<C-g>' " visual mode multicursor

" vim-commentary
autocmd FileType prisma setlocal commentstring=//\ %s

" Easy align - normally use for assignment format
vnoremap <silent> =1 :EasyAlign 1=<CR>
" " Start interactive EasyAlign in visual mode (e.g. vipga)
" xmap ga <Plug>(EasyAlign)
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nmap ga <Plug>(EasyAlign)

" telescope
nnoremap <leader>p :call OpenWithTelescope('find_files')<cr>
nnoremap <leader>P :call OpenWithTelescope('live_grep')<cr>
nnoremap <leader>b :call OpenWithTelescope('buffers')<cr>
nnoremap <leader>f <cmd>Telescope lsp_document_symbols ignore_symbols=namespace,class,constant,variable,property<cr>
nnoremap <leader>F <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <leader>h <cmd>Telescope help_tags<cr>
" nnoremap <silent>ff <cmd>Telescope lsp_document_symbols default_text=:method:<cr>

" Avoid open file in NERDTree buffer
function! OpenWithTelescope(command)
  if &ft !=# 'nerdtree'
    exe 'Telescope ' . a:command
  else
    wincmd p
    exe 'Telescope ' . a:command
  endif
endfunction

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

" ToggleTerm
" By applying the mappings this way you can pass a count to your
" mapping to open a specific window.
" For example: 2<C-t> will open terminal 2
" nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
" inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

" pre-requisite for colorizer
set termguicolors

" set fold to treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
set foldlevelstart=1

""""""""""""""""""""""""
""" START LUA CONFIG """
""""""""""""""""""""""""
lua << EOF
require'colorizer'.setup()
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
      "intelephense",
      "tsserver",
      "quick_lint_js",
      "prismals",
      "astro",
      "svelte",
    },
    automatic_installation = true,
})

require'nvim-treesitter.configs'.setup{
  auto_install = true,
  indent = {
    enable = true
  },
  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  }
}

require('nvim-ts-autotag').setup()

-- install language server
require'lspconfig'.gopls.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.bashls.setup{}
-- require'lspconfig'.phan.setup{}
require'lspconfig'.terraformls.setup{}
require'lspconfig'.jedi_language_server.setup{} -- python

-- store intelephense license key at HOME/intelephense/licence.txt (no I am not spelling it wrong)
require'lspconfig'.intelephense.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.quick_lint_js.setup{}
require'lspconfig'.astro.setup{}
require'lspconfig'.prismals.setup{}
require'lspconfig'.svelte.setup{}
require'lspconfig'.rust_analyzer.setup{}
--     settings = {
--         ['rust-analyzer'] = {
--             -- check = {
--             --     command = "clippy";
--             -- },
--             diagnostics = {
--                 enable = false;
--             }
--         }
--     }
-- }

require("codecompanion").setup({
  adapters = {
    inline = "ollama",
    chat = require("codecompanion.adapters").use("ollama", {
        schema = {
            model = {
                default = "llama3",
            },
        },
    }),
    -- inline = require("codecompanion.adapters").use("openai", {
    --   env = {
    --     api_key = "cmd:gpg --decrypt ~/.openai-api-key.gpg 2>/dev/null",
    --   },
    -- }),
    -- chat = require("codecompanion.adapters").use("openai", {
    --   env = {
    --     api_key = "cmd:gpg --decrypt ~/.openai-api-key.gpg 2>/dev/null",
    --   },
    -- }),
  },
})
require("edgy").setup({
  animate = {
    enabled = false,
  },
  left = {
    {
      ft = "nerdtree",
      size = { width = 0.2 }
    },
  },
  right = {
    {
      ft = "codecompanion",
      title = "Code Companion Chat",
      size = { width = 0.45 }
    },
  },
  -- bottom = {
  --   {
  --     ft = "toggleterm",
  --     title = "Terminal",
  --     size = { width = 0.45 }
  --   },
  -- },
})

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
local cmp = require'cmp'
cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
      -- ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
})

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

