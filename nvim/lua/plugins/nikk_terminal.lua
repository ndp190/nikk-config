local floating_term_buf = nil
local floating_term_win = nil

-- Toggle the floating terminal window - faster than ToggleTerm plugin
function _G.toggle_nikk_terminal()
    if floating_term_win ~= nil and vim.api.nvim_win_is_valid(floating_term_win) then
        -- Close the terminal window if it's already open
        vim.api.nvim_win_hide(floating_term_win)
        floating_term_win = nil
    else

        -- Create the floating window
        local width = math.floor(vim.o.columns * 0.8)
        local height = math.floor(vim.o.lines * 0.8)
        local col = math.floor((vim.o.columns - width) / 2)
        local row = math.floor((vim.o.lines - height) / 2)

        local opts = {
            style = "minimal",
            relative = "editor",
            width = width,
            height = height,
            col = col,
            row = row,
            border = "single",
        }

        local is_new_buf = false
        if floating_term_buf == nil or not vim.api.nvim_buf_is_valid(floating_term_buf) then
            -- Create the terminal buffer if it doesn't exist
            floating_term_buf = vim.api.nvim_create_buf(false, true)
            is_new_buf = true
        end
        floating_term_win = vim.api.nvim_open_win(floating_term_buf, true, opts)
        if is_new_buf then
            vim.fn.termopen(vim.o.shell)
        end
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.cmd("startinsert")
    end
end

return {}
