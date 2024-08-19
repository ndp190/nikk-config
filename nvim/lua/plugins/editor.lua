-- visualize tab/trailing space/... characters
vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·', extends = '…', precedes = '…', nbsp = '␣' }

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
        -- open neotree (override netrw) when 'vim .'
        init = function()
          if vim.fn.argc(-1) == 1 then
            local stat = vim.loop.fs_stat(vim.fn.argv(0))
            if stat and stat.type == "directory" then
              require("neo-tree").setup(neo_tree_setup)
            end
          end
        end,
        config = function()
          require('neo-tree').setup(neo_tree_setup)
        end
    },

    -- move between vim and tmux panes (using vim motions)
    {
        "christoomey/vim-tmux-navigator",
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
}
