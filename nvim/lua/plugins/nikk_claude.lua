-- Global state for cross-module access
_G.nikk_claude_buf = nil
_G.nikk_claude_win = nil

-- Toggle the floating terminal window - faster than ToggleTerm plugin
function _G.toggle_nikk_claude()
    local claude_open = _G.nikk_claude_win ~= nil and vim.api.nvim_win_is_valid(_G.nikk_claude_win)
    local term_open = _G.nikk_terminal_win ~= nil and vim.api.nvim_win_is_valid(_G.nikk_terminal_win)
    local current_win = vim.api.nvim_get_current_win()

    if claude_open then
        local claude_is_focused = current_win == _G.nikk_claude_win
        if claude_is_focused or not term_open then
            -- Claude is focused or only claude open: close it
            vim.api.nvim_win_hide(_G.nikk_claude_win)
            _G.nikk_claude_win = nil
        else
            -- Claude open but terminal is focused: bring claude to front
            vim.api.nvim_win_hide(_G.nikk_claude_win)
            _G.nikk_claude_win = nil
            _G.open_nikk_claude()
        end
    else
        -- Claude not open: open it
        _G.open_nikk_claude()
    end
end

-- Check if buffer has a running terminal job
local function is_terminal_running(buf)
    if buf == nil or not vim.api.nvim_buf_is_valid(buf) then
        return false
    end
    local chan = vim.bo[buf].channel
    return chan ~= nil and chan > 0 and vim.fn.jobwait({chan}, 0)[1] == -1
end

function _G.open_nikk_claude()
    local width = math.floor(vim.o.columns * 0.8)
    local height = vim.o.lines - 2  -- Full height minus statusline/cmdline
    local col = vim.o.columns - width  -- Position at right edge
    local row = 0

    local opts = {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        border = "none",
    }

    local need_new_terminal = false
    if _G.nikk_claude_buf == nil or not vim.api.nvim_buf_is_valid(_G.nikk_claude_buf) then
        _G.nikk_claude_buf = vim.api.nvim_create_buf(false, true)
        need_new_terminal = true
    elseif not is_terminal_running(_G.nikk_claude_buf) then
        -- Buffer exists but terminal exited, create new buffer
        vim.api.nvim_buf_delete(_G.nikk_claude_buf, { force = true })
        _G.nikk_claude_buf = vim.api.nvim_create_buf(false, true)
        need_new_terminal = true
    end
    _G.nikk_claude_win = vim.api.nvim_open_win(_G.nikk_claude_buf, true, opts)
    if need_new_terminal then
        vim.fn.termopen("claude")
    end
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.winhighlight = "Normal:Normal"
    vim.wo.winblend = 15
    -- Pass space through immediately without waiting for leader key timeout
    vim.api.nvim_buf_set_keymap(_G.nikk_claude_buf, 't', '<Space>', '<Space>', { nowait = true, noremap = true })
    vim.cmd("startinsert")
end

return {}
