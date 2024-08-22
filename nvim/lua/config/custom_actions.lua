 local actions = require('telescope.actions')
 local action_state = require('telescope.actions.state')
 local pickers = require('telescope.pickers')
 local finders = require('telescope.finders')
 local conf = require('telescope.config').values

 local custom_actions = {
     {name = "Close all buffers but the current one", action = function()
         vim.cmd('%bd|e#|bd#')
     end},
     -- Add more custom actions here
 }

 function open_custom_actions()
     pickers.new({}, {
         prompt_title = "Custom Actions",
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
         -- sorter = conf.generic_sorter({}),
         async = true,
         sorter = nil,
         attach_mappings = function(_, map)
             actions.select_default:replace(function(prompt_bufnr)
                 actions.close(prompt_bufnr)
                 local selection = action_state.get_selected_entry()
                 selection.value.action()
             end)
             return true
         end,
     }):find()
 end

 -- Map <leader>a to open the custom actions picker
 vim.api.nvim_set_keymap('n', '<leader>a', ':lua open_custom_actions()<CR>', { noremap = true, silent = true })


