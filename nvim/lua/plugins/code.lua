-- set fold to treesitter
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldenable = false
vim.wo.foldlevel = 99

-- Set tab and indentation options globally
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
local function set_tab_and_indent(tabstop, shiftwidth, softtabstop)
    vim.opt_local.tabstop = tabstop
    vim.opt_local.shiftwidth = shiftwidth
    vim.opt_local.softtabstop = softtabstop
end
-- Set up autocmds for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python", "typescript", "typescriptreact", "javascript", "html", "css", "ruby" },
    callback = function(params)
        local tabwidth = 2
        if params.match == "python" or params.match == "php" then
            tabwidth = 4
        end
        set_tab_and_indent(tabwidth, tabwidth, tabwidth)
    end,
})

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "intelephense",
                    "tsserver",
                    "quick_lint_js",
                    "prismals",
                    "astro",
                },
                automatic_installation = true,
            })
            require 'lspconfig'.lua_ls.setup {}
            require 'lspconfig'.gopls.setup {}
            require 'lspconfig'.jsonls.setup {}
            require 'lspconfig'.bashls.setup {}
            require 'lspconfig'.terraformls.setup {}
            require 'lspconfig'.jedi_language_server.setup {} -- python
            -- store intelephense license key at HOME/intelephense/licence.txt (no I am not spelling it wrong)
            require 'lspconfig'.intelephense.setup {}
            require 'lspconfig'.tsserver.setup {}
            require 'lspconfig'.quick_lint_js.setup {}
            require 'lspconfig'.astro.setup {}
            require 'lspconfig'.prismals.setup {}
            require 'lspconfig'.svelte.setup {}
            require 'lspconfig'.rust_analyzer.setup {}
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ':TSUpdate',
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
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
        end,
    },

    -- autocomplete
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
        },
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        config = function()
            -- Your nvim-cmp setup can go here
            local cmp = require 'cmp'
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
        end
    },

    -- anyjump: fallback in case LSP fail, also more performant
    {
        "pechorin/any-jump.vim",
    },

    -- bookmark
    {
        "tomasky/bookmarks.nvim",
        dependencies = { 'nvim-telescope/telescope.nvim' },
        config = function()
            require('bookmarks').setup({
                save_file = vim.fn.expand "$HOME/.bookmarks",
                keywords = {
                    ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
                    ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
                    ["@f"] = "⛏️ ", -- mark annotation startswith @f ,signs this icon as `Fix`
                    ["@n"] = "🔖 ", -- mark annotation startswith @n ,signs this icon as `Note`
                },
                on_attach = function(bufnr)
                    local bm = require "bookmarks"
                    local map = vim.keymap.set
                    map("n", "mm", bm.bookmark_toggle) -- add or remove bookmark at current line
                    map("n", "mi", bm.bookmark_ann)  -- add or edit mark annotation at current line
                    map("n", "mc", bm.bookmark_clean) -- clean all marks in local buffer
                    map("n", "mn", bm.bookmark_next) -- jump to next mark in local buffer
                    map("n", "mp", bm.bookmark_prev) -- jump to previous mark in local buffer
                    -- map("n","ml",bm.bookmark_list) -- show marked file list in quickfix window
                    -- map("n","mx",bm.bookmark_clear_all) -- removes all bookmarks
                end,
            })
        end
    },

    -- code comments - type `gcc`
    {
        "tpope/vim-commentary",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        config = function()
            -- comment for prisma
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "prisma",
                callback = function()
                    vim.opt_local.commentstring = "// %s"
                end,
            })
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    },

    -- copilot
    {
        "github/copilot.vim",
    },

    -- indentation
    {
        "junegunn/vim-easy-align",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    },
}
