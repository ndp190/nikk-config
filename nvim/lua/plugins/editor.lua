-- visualize tab/trailing space/... characters
vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·', extends = '…', precedes = '…', nbsp = '␣' }

-- enable line numbers
vim.opt.number = true

-- enable mouse in neovim context
-- vim.opt.mouse = 'a'

local neo_tree_setup = {
  filesystem = {
    hijack_netrw_behavior = "open_current",
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
              },
          })
          require('telescope').load_extension('bookmarks')
        end
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
            vim.g['airline#extensions#wordcount#filetypes'] = '\\vasciidoc|help|mail|markdown|markdown.pandoc|org|rst|tex|text'
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
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
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
       "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup{
              size = function(term)
                 if term.direction == "horizontal" then
                   return 20 
                 elseif term.direction == "vertical" then
                   return vim.o.columns * 0.4
                 end
               end,
              open_mapping = [[<c-t>]],
              hide_numbers = true, -- hide the number column in toggleterm buffers
              shade_filetypes = {},
              shade_terminals = false,
              start_in_insert = true,
              insert_mappings = true, -- whether or not the open mapping applies in insert mode
              terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
              persist_size = true,
              direction = 'float',
              close_on_exit = true, -- close the terminal window when the process exits
              shell = vim.o.shell, -- change the default shell
            }
        end,
    },

    -- terminal
    {
        "mg979/vim-visual-multi",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    },

    {
      'stevearc/oil.nvim',
      opts = {},
      -- Optional dependencies
      -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
      dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
      config = function()
        require("oil").setup({
          -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
          -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
          default_file_explorer = true,
          -- See :help oil-columns
          columns = {
            "icon",
            "permissions",
            "size",
            "mtime",
          },
          -- Set to true to watch the filesystem for changes and reload oil
          watch_for_changes = false,
          -- See :help oil-actions for a list of all available actions
          keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
            ["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
            ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["<C-r>"] = "actions.refresh",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
            ["gs"] = "actions.change_sort",
            ["gx"] = "actions.open_external",
            ["g."] = "actions.toggle_hidden",
            ["g\\"] = "actions.toggle_trash",
          },
          -- Set to false to disable all of the above keymaps
          use_default_keymaps = false,
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
            natural_order = true,
            -- Sort file and directory names case insensitive
            case_insensitive = false,
            sort = {
              -- sort order can be "asc" or "desc"
              -- see :help oil-columns to see which columns are sortable
              { "type", "asc" },
              { "name", "asc" },
            },
          },
          -- Extra arguments to pass to SCP when moving/copying files over SSH
          extra_scp_args = {},
          -- EXPERIMENTAL support for performing file operations with git
          git = {
            -- Return true to automatically git add/mv/rm files
            add = function(path)
              return false
            end,
            mv = function(src_path, dest_path)
              return false
            end,
            rm = function(path)
              return false
            end,
          },
          -- Configuration for the floating window in oil.open_float
          float = {
            -- Padding around the floating window
            padding = 2,
            max_width = 0,
            max_height = 0,
            border = "rounded",
            win_options = {
              winblend = 0,
            },
            -- preview_split: Split direction: "auto", "left", "right", "above", "below".
            preview_split = "auto",
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            override = function(conf)
              return conf
            end,
          },
          -- Configuration for the actions floating preview window
          preview = {
            -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- min_width and max_width can be a single value or a list of mixed integer/float types.
            -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
            max_width = 0.9,
            -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
            min_width = { 40, 0.4 },
            -- optionally define an integer/float for the exact width of the preview window
            width = nil,
            -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- min_height and max_height can be a single value or a list of mixed integer/float types.
            -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
            max_height = 0.9,
            -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
            min_height = { 5, 0.1 },
            -- optionally define an integer/float for the exact height of the preview window
            height = nil,
            border = "rounded",
            win_options = {
              winblend = 0,
            },
            -- Whether the preview window is automatically updated when the cursor is moved
            update_on_cursor_moved = true,
          },
          -- Configuration for the floating progress window
          progress = {
            max_width = 0.9,
            min_width = { 40, 0.4 },
            width = nil,
            max_height = { 10, 0.9 },
            min_height = { 5, 0.1 },
            height = nil,
            border = "rounded",
            minimized_border = "none",
            win_options = {
              winblend = 0,
            },
          },
          -- Configuration for the floating SSH window
          ssh = {
            border = "rounded",
          },
          -- Configuration for the floating keymaps help window
          keymaps_help = {
            border = "rounded",
          },
        })
      end,
    }
}
