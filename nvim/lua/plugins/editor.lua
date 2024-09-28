-- visualize tab/trailing space/... characters
vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·', extends = '…', precedes = '…', nbsp = '␣' }

-- enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- enable mouse in neovim context
-- vim.opt.mouse = 'a'

local neo_tree_setup = {
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_by_name = {
                "node_modules",
                ".git",
                ".vscode",
            },
            hide_by_pattern = { -- uses glob style patterns
                -- "*.git",
                -- "*.vscode",
            },
            always_show = {
                ".env",
                ".github",
            },
            always_show_by_pattern = { -- uses glob style patterns
                ".env*",
            },
        },
        follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
        },
    },
}

return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local z_utils = require("telescope._extensions.zoxide.utils")
            local oil = require("oil")
            require('telescope').setup({
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
                    sorting_strategy = "ascending",
                    layout_strategy = "flex",
                    layout_config = {
                        horizontal = {
                            anchor = "SE",
                            mirror = false,
                            prompt_position = "top",
                        },
                        vertical = {
                            anchor = "S",
                            mirror = true,
                            prompt_position = "top",
                        },
                    },
                    file_sorter = require 'telescope.sorters'.get_fuzzy_file,
                    file_ignore_patterns = { "dist/.*", "node_modules/.*", "vendor/.*", "packages/.*", ".git/", ".gitignore", ".gitkeep", ".next", "package-lock.json" },
                },
                pickers = {
                    live_grep = {
                        additional_args = function(opts)
                            return { "--hidden" }
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
                },
                extensions = {
                    zoxide = {
                        prompt_title = "[ Jump to folder ]",
                        mappings = {
                            default = {
                                after_action = function(selection)
                                    print("Update to (" .. selection.z_score .. ") " .. selection.path)
                                    oil.open(selection.path)
                                end
                            },
                            -- ["<C-s>"] = {
                            --   before_action = function(selection) print("before C-s") end,
                            --   action = function(selection)
                            --     vim.cmd.edit(selection.path)
                            --   end
                            -- },
                            -- Opens the selected entry in a new split
                            ["<C-q>"] = { action = z_utils.create_basic_command("split") },
                        },
                    }
                }
            })
            require('telescope').load_extension('bookmarks')
            require("telescope").load_extension('zoxide')
        end
    },

    -- telescope zoxide (better 'cd') integration
    {
        "jvgrootveld/telescope-zoxide",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim"
        },
    },


    -- Status line
    {
        'vim-airline/vim-airline',
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        config = function()
            -- enable airline
            vim.opt.laststatus = 2
            vim.g['airline#extensions#wordcount#enabled'] = 1
            vim.g['airline#extensions#tabline#enabled'] = 1
            vim.g['airline#extensions#tabline#tab_nr_type'] = 1
            vim.g['airline#extensions#tabline#show_tab_nr'] = 1
            vim.g['airline#extensions#tabline#formatter'] = 'default'
            vim.g['airline#extensions#tabline#fnametruncate'] = 32
            vim.g['airline#extensions#tabline#fnamecollapse'] = 2
            vim.g['airline#extensions#tabline#buffer_nr_show'] = 1
            vim.g['airline#extensions#wordcount#filetypes'] =
            '\\vasciidoc|help|mail|markdown|markdown.pandoc|org|rst|tex|text'
            vim.g['airline#extensions#tabline#buffer_idx_mode'] = 1
        end,
    },
    {
        "gcavallanti/vim-noscrollbar",
        dependencies = { "vim-airline/vim-airline", "ompugao/vim-airline-noscrollbar" },
    },

    -- Neotree plugin configuration
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        -- open neotree (override netrw) when 'vim .'
        -- init = function()
        --   if vim.fn.argc(-1) == 1 then
        --     local stat = vim.loop.fs_stat(vim.fn.argv(0))
        --     if stat and stat.type == "directory" then
        --       require("neo-tree").setup(neo_tree_setup)
        --     end
        --   end
        -- end,
        config = function()
            require('neo-tree').setup(neo_tree_setup)
        end
    },

    -- move between vim and tmux panes (using vim motions)
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },

    -- copy to clipboard
    {
        "christoomey/vim-system-copy",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    },

    -- skin
    {
        "morhetz/gruvbox",
        config = function()
            vim.cmd('colorscheme gruvbox')
        end,
    },

    -- toggle fullscreen
    {
        "troydm/zoomwintab.vim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    },

    -- terminal
    {
        "mg979/vim-visual-multi",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    },

    -- buffer close
    {
        "Asheq/close-buffers.vim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    },

    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
        config = function()
            local columns_enabled = false
            require("oil").setup({
                -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
                -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
                default_file_explorer = true,
                -- See :help oil-columns
                columns = { "icon" },
                -- Set to true to watch the filesystem for changes and reload oil
                watch_for_changes = false,
                -- See :help oil-actions for a list of all available actions
                keymaps = {
                    ["g?"] = "actions.show_help",
                    ["<CR>"] = "actions.select",
                    ["gv"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
                    ["gx"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
                    ["gt"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
                    ["gp"] = "actions.preview",
                    ["<C-c>"] = "actions.close",
                    ["<C-r>"] = "actions.refresh",
                    ["-"] = "actions.parent",
                    ["_"] = "actions.open_cwd",
                    ["`"] = "actions.cd",
                    ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
                    ["gs"] = "actions.change_sort",
                    ["go"] = "actions.open_external",
                    ["g."] = "actions.toggle_hidden",
                    ["g\\"] = "actions.toggle_trash",
                    ["gc"] = function()
                        if columns_enabled then
                            require("oil").set_columns({ "icon" })
                        else
                            require("oil").set_columns({
                                "icon",
                                "permissions",
                                "size",
                                "mtime",
                            })
                        end
                        columns_enabled = not columns_enabled
                    end,
                },
                -- Set to false to disable all of the above keymaps
                use_default_keymaps = false,
                delete_to_trash = true,
                view_options = {
                    -- Show files and directories that start with "."
                    show_hidden = true,
                    -- This function defines what is considered a "hidden" file
                    is_hidden_file = function(name, bufnr)
                        return vim.startswith(name, ".")
                    end,
                    -- This function defines what will never be shown, even when `show_hidden` is set
                    is_always_hidden = function(name, bufnr)
                        return false
                    end,
                    -- Sort file names in a more intuitive order for humans. Is less performant,
                    -- so you may want to set to false if you work with large directories.
                    natural_order = false,
                    -- Sort file and directory names case insensitive
                    case_insensitive = false,
                    sort = {
                        -- sort order can be "asc" or "desc"
                        -- see :help oil-columns to see which columns are sortable
                        { "type", "asc" },
                        { "name", "asc" },
                    },
                }
            })
        end,
    },

    {
        "chrisgrieser/nvim-various-textobjs",
        event = "UIEnter",
        opts = { useDefaultKeymaps = true },
    },

    {
        "rest-nvim/rest.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        config = function()
            require('rest-nvim').setup({
                -- Add any configuration options here if needed
            })
        end,
    }

}
