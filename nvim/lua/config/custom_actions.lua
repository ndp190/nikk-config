local themes = require('telescope.themes')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values

local custom_actions = {
    {
        name = "Close all buffers but the current one",
        action = function()
            vim.cmd('Bdelete other')
        end
    },
    -- Add more custom actions here
}

open_custom_actions = function()
    pickers.new(themes.get_cursor{}, {
        prompt_title = "Nikk's Custom Actions 🐒",
        finder = finders.new_table {
            results = custom_actions,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.name,
                    ordinal = entry.name,
                }
            end,
        },
        sorter = conf.generic_sorter({}),
        attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry(prompt_bufnr)
                require('telescope.actions').close(prompt_bufnr)
                selection.value.action()
            end)
            map('n', '<CR>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry(prompt_bufnr)
                require('telescope.actions').close(prompt_bufnr)
                selection.value.action()
            end)
            return true
        end,
    }):find()
end
