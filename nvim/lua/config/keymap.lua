vim.g.mapleader = " "

-- mg979/vim-visual-multi key mappings
vim.g.VM_maps = {
    ["Find Under"] = "<C-g>",         -- normal mode multicursor
    ["Find Subword Under"] = "<C-g>", -- visual mode multicursor
}

local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { silent = true })
end

map("n", "<C-t>", "<CMD>:lua toggle_nikk_terminal()<CR>")
map("t", "<C-t>", "<CMD>:lua toggle_nikk_terminal()<CR>")

map("n", "na", "<CMD>:lua open_custom_actions()<CR>")

vim.api.nvim_create_user_command('ToggleRelativeNumber', function()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, {})

vim.api.nvim_create_user_command('CurrentPath', function()
    local buffer_path = vim.api.nvim_buf_get_name(0)
    print(buffer_path)
end, {})

map("n", "=3", "<CMD>:ToggleRelativeNumber<CR>")
map("n", "==", "<CMD>:CurrentPath<CR>")

-- buffer
map("n", "<leader>q", "<CMD>:q<CR>")
map("n", "<leader>Q", "<CMD>:q!<CR>")
map("n", "<leader>s", "<CMD>:w<CR>")
map("n", "<leader>n", "<CMD>:enew<CR>")
map("n", "<leader>w", "<CMD>:bp<BAR>bd#<CR>")
map("n", "<leader>W", "<CMD>:bp<BAR>bd!#<CR>")
map("n", "<C-n>", "<CMD>:bnext<CR>")
map("n", "<C-p>", "<CMD>:bprev<CR>")
map("n", "<C-w>x", "<CMD>:split<CR>")
map("n", "<C-w>v", "<CMD>:vsplit<CR>")

-- NeoTree
map("n", "<leader>e", "<CMD>Neotree toggle<CR>")
map("n", "<leader>r", "<CMD>Neotree reveal<CR>")
-- Oil
map("n", "<leader>E", "<CMD>Oil .<CR>")
-- Zoxide
map("n", "<leader>z", require("telescope").extensions.zoxide.list)

-- Clear highlights
map("n", "<leader>l", "<CMD>:noh<CR>")

-- LSP Telescope
map("n", "<leader>p", "<CMD>Telescope find_files<CR>")
map("n", "<leader>P", "<CMD>Telescope live_grep<CR>")
map("n", "<leader>b", "<CMD>Telescope buffers<CR>")
map("n", "<leader>f", "<CMD>Telescope lsp_document_symbols ignore_symbols=namespace,class,constant,variable,property<CR>")
map("n", "<leader>F", "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>")
map("n", "<leader>h", "<CMD>Telescope help_tags<CR>")
map("n", "gd", "<CMD>Telescope lsp_definitions<CR>")
map("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>")
map("n", "gr",
    "<CMD>lua require('telescope.builtin').lsp_references({ on_complete = { function() vim.cmd'stopinsert' end } })<CR>")
map("n", "gR", "<CMD>lua vim.lsp.buf.rename()<CR>")
map("n", "gi", "<CMD>Telescope lsp_implementations<CR>")
map("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>")
map("n", "ga", "<CMD>lua vim.lsp.buf.code_action()<CR>")
map("n", "<C-k>", "<CMD>lua vim.lsp.buf.signature_help()<CR>")
map("n", "gp", "<CMD>lua vim.diagnostic.goto_prev()<CR>")
map("n", "gn", "<CMD>lua vim.diagnostic.goto_next()<CR>")
map("n", "gf", "<CMD>lua vim.lsp.buf.format({ async=true })<CR>")
map("v", "gf", "<CMD>lua vim.lsp.buf.range_formatting()<CR>")
map("n", "gm", "<CMD>:exec ':setf ' .input('set language: ')<CR>")
map("n", "ma", "<CMD>lua require('telescope').extensions.bookmarks.list()<CR>")

-- Align
map("v", "=1", "<CMD>:EasyAlign 1=<CR>")

-- git
map("n", "<leader>gs", "<CMD>:G<CR>")

-- Airline
map("n", "<leader>1", "<Plug>AirlineSelectTab1")
map("n", "<leader>2", "<Plug>AirlineSelectTab2")
map("n", "<leader>3", "<Plug>AirlineSelectTab3")
map("n", "<leader>4", "<Plug>AirlineSelectTab4")
map("n", "<leader>5", "<Plug>AirlineSelectTab5")
map("n", "<leader>6", "<Plug>AirlineSelectTab6")
map("n", "<leader>7", "<Plug>AirlineSelectTab7")
map("n", "<leader>8", "<Plug>AirlineSelectTab8")
map("n", "<leader>9", "<Plug>AirlineSelectTab9")
print("keymap.lua loaded")

-- Specific buffer mapping
-- rest nvim
local selected_env = nil
-- Override vim.notify to catch environment notifications
local original_notify = nil
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'http',
    callback = function()
        if not original_notify then
            original_notify = vim.notify
            vim.notify = function(msg, level, opts)
                -- Check if the notification is from rest.nvim and contains the env file registration message
                if opts and opts.title == "rest.nvim" and msg:match("Env file '.*' has been registered") then
                    selected_env = msg:match("Env file '(.*)' has been registered")
                end

                -- Call the original vim.notify function to keep standard behavior
                original_notify(msg, level, opts)
            end
        end

        -- If an environment is already selected, set it
        if selected_env then
            vim.cmd("Rest env set " .. selected_env)
        end

        map("n", "gr", "<CMD>:Rest run<CR>")
        map("n", "ge", "<CMD>:Rest env select<CR>")
        map("n", "go", "<CMD>:Rest open<CR>")
        map("n", "gu", "<CMD>:Rest curl comment<CR>")
    end,
})
