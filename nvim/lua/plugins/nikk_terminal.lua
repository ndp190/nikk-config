-- Global state for cross-module access
_G.nikk_terminal_buf = nil
_G.nikk_terminal_win = nil
_G.nikk_lazygit_buf = nil
_G.nikk_lazygit_win = nil

-- Toggle the floating terminal window - faster than ToggleTerm plugin
function _G.toggle_nikk_terminal()
    local term_open = _G.nikk_terminal_win ~= nil and vim.api.nvim_win_is_valid(_G.nikk_terminal_win)
    local claude_open = _G.nikk_claude_win ~= nil and vim.api.nvim_win_is_valid(_G.nikk_claude_win)
    local current_win = vim.api.nvim_get_current_win()

    if term_open then
        local term_is_focused = current_win == _G.nikk_terminal_win
        if term_is_focused or not claude_open then
            -- Terminal is focused or only terminal open: close it
            vim.api.nvim_win_hide(_G.nikk_terminal_win)
            _G.nikk_terminal_win = nil
        else
            -- Terminal open but claude is focused: bring terminal to front
            vim.api.nvim_win_hide(_G.nikk_terminal_win)
            _G.nikk_terminal_win = nil
            _G.open_nikk_terminal()
        end
    else
        -- Terminal not open: open it
        _G.open_nikk_terminal()
    end
end

function _G.open_nikk_terminal()
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
        border = "none",
    }

    local is_new_buf = false
    if _G.nikk_terminal_buf == nil or not vim.api.nvim_buf_is_valid(_G.nikk_terminal_buf) then
        _G.nikk_terminal_buf = vim.api.nvim_create_buf(false, true)
        is_new_buf = true
    end
    _G.nikk_terminal_win = vim.api.nvim_open_win(_G.nikk_terminal_buf, true, opts)
    if is_new_buf then
        vim.fn.termopen(vim.o.shell)
    end
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.winblend = 15
    vim.api.nvim_buf_set_keymap(_G.nikk_terminal_buf, 't', '<Space>', '<Space>', { nowait = true, noremap = true })
    vim.cmd("startinsert")
end

-- Toggle lazygit floating window - keeps process running when hidden
function _G.toggle_nikk_lazygit()
    local lg_open = _G.nikk_lazygit_win ~= nil and vim.api.nvim_win_is_valid(_G.nikk_lazygit_win)

    if lg_open then
        vim.api.nvim_win_hide(_G.nikk_lazygit_win)
        _G.nikk_lazygit_win = nil
    else
        _G.open_nikk_lazygit()
    end
end

function _G.open_nikk_lazygit()
    local width = math.floor(vim.o.columns * 0.9)
    local height = math.floor(vim.o.lines * 0.9)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local opts = {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        border = "rounded",
    }

    local is_new_buf = false
    if _G.nikk_lazygit_buf == nil or not vim.api.nvim_buf_is_valid(_G.nikk_lazygit_buf) then
        _G.nikk_lazygit_buf = vim.api.nvim_create_buf(false, true)
        is_new_buf = true
    end
    _G.nikk_lazygit_win = vim.api.nvim_open_win(_G.nikk_lazygit_buf, true, opts)
    if is_new_buf then
        vim.fn.termopen("lazygit", {
            on_exit = function()
                -- Clean up when lazygit actually exits (user pressed q)
                if _G.nikk_lazygit_win and vim.api.nvim_win_is_valid(_G.nikk_lazygit_win) then
                    vim.api.nvim_win_close(_G.nikk_lazygit_win, true)
                end
                _G.nikk_lazygit_buf = nil
                _G.nikk_lazygit_win = nil
            end
        })
    end
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.winblend = 10
    vim.api.nvim_buf_set_keymap(_G.nikk_lazygit_buf, 't', '<Space>', '<Space>', { nowait = true, noremap = true })
    vim.cmd("startinsert")
end

return {}
