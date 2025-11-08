local themes = require('telescope.themes')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values

local function display_timezones(input_time)
    local function get_time_for_timezone(tz, base_time)
        local date_command
        if base_time then
            -- Use specific time if provided
            date_command = string.format(
                'date -j -f "%%Y-%%m-%%d %%H:%%M" "%s" "+%%s" | xargs -I{} env TZ="%s" date -j -f "%%s" "{}" "+%%Y-%%m-%%d %%H:%%M:%%S"',
                base_time, tz
            )
        else
            -- Use current time if no base time provided
            date_command = string.format('env TZ="%s" date "+%%Y-%%m-%%d %%H:%%M:%%S"', tz)
        end
        return vim.fn.system(date_command):gsub("\n", "")
    end

    local your_timezone = "Asia/Ho_Chi_Minh" -- Replace with your local timezone
    local casey_timezone = "America/Los_Angeles"
    local gary_timezone = "Australia/Brisbane"

    -- Use current time if no input is provided
    local base_time
    if input_time and input_time ~= "" then
        base_time = os.date("%Y-%m-%d") .. " " .. input_time
    else
        base_time = nil -- Indicates to use the current time
    end

    local your_time = get_time_for_timezone(your_timezone, base_time)
    local casey_time = get_time_for_timezone(casey_timezone, base_time)
    local gary_time = get_time_for_timezone(gary_timezone, base_time)

    local message = "Your time (" .. your_timezone .. "): " .. your_time .. "\n"
        .. "Casey time (" .. casey_timezone .. "): " .. casey_time .. "\n"
        .. "Sang/Gary time: (" .. gary_timezone .. "): " .. gary_time

    vim.api.nvim_echo({ { message } }, false, {})
end

local function prompt_for_time()
    local input = vim.fn.input('Enter time in 24h format (e.g. 13:00) or press Enter for current time: ')
    if input == nil or input == '' then
        -- Default to the current time if the input is empty
        input = os.date("%H:%M")
    else
        -- Optionally validate the input format (24-hour format)
        if not input:match("^%d%d:%d%d$") then
            print("Invalid time format. Please use HH:MM.")
            return
        end
    end
    display_timezones(input)
end

local custom_actions = {
    {
        name = "Close all buffers but the current one",
        action = function()
            vim.cmd('Bdelete other')
        end
    },
    {
        name = "Display timezones",
        action = prompt_for_time
    },
    {
        name = "Toggle Diff Window",
        action = function()
            if vim.wo.diff then
                vim.cmd('windo diffoff')
            else
                vim.cmd('windo diffthis')
            end
        end
    },
}


open_custom_actions = function()
    pickers.new(themes.get_cursor {}, {
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

return {}
