vim.g.mapleader = " "

-- mg979/vim-visual-multi key mappings
vim.g.VM_maps = {
    ["Find Under"] = "<C-g>",         -- normal mode multicursor
    ["Find Subword Under"] = "<C-g>", -- visual mode multicursor
}

local function map(mode, lhs, rhs, opts)
    local options = vim.tbl_extend("force", { silent = true }, opts or {})
    vim.keymap.set(mode, lhs, rhs, options)
end

map("n", "<C-t>", "<CMD>:lua toggle_nikk_terminal()<CR>", { desc = "Toggle terminal" })
map("t", "<C-t>", "<CMD>:lua toggle_nikk_terminal()<CR>", { desc = "Toggle terminal" })
map("t", "<leader>lg", "<CMD>:lua toggle_nikk_lazygit()<CR>", { desc = "Open LazyGit" })
map("n", "<leader>lg", "<CMD>:lua toggle_nikk_lazygit()<CR>", { desc = "Open LazyGit" })
map("n", "<C-a>", "<CMD>:lua toggle_nikk_claude()<CR>", { desc = "Toggle AI terminal" })
map("t", "<C-a>", "<CMD>:lua toggle_nikk_claude()<CR>", { desc = "Toggle AI terminal" })

map("n", "<leader>Na", "<CMD>:lua open_custom_actions()<CR>", { desc = "Open custom actions" })

vim.api.nvim_create_user_command('ToggleRelativeNumber', function()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, {})

vim.api.nvim_create_user_command('CurrentPath', function()
    local buffer_path = vim.api.nvim_buf_get_name(0)
    print(buffer_path)
end, {})

map("n", "=3", "<CMD>:ToggleRelativeNumber<CR>", { desc = "Toggle relative numbers" })
map("n", "==", "<CMD>:CurrentPath<CR>", { desc = "Show current file path" })

-- buffer
map("n", "<leader>q", "<CMD>:q<CR>", { desc = "Quit window" })
map("n", "<leader>Q", "<CMD>:q!<CR>", { desc = "Force quit window" })
map("n", "<leader>s", "<CMD>:w<CR>", { desc = "Save buffer" })
map("n", "<leader>n", "<CMD>:enew<CR>", { desc = "New buffer" })
map("n", "<leader>w", "<CMD>:bp<BAR>bd#<CR>", { desc = "Close buffer" })
map("n", "<leader>W", "<CMD>:bp<BAR>bd!#<CR>", { desc = "Force close buffer" })
map("n", "<C-n>", "<CMD>:bnext<CR>", { desc = "Next buffer" })
map("n", "<C-p>", "<CMD>:bprev<CR>", { desc = "Previous buffer" })
map("n", "<C-w>x", "<CMD>:split<CR>", { desc = "Horizontal split" })
map("n", "<C-w>v", "<CMD>:vsplit<CR>", { desc = "Vertical split" })

-- NeoTree
map("n", "<leader>e", "<CMD>Neotree toggle<CR>", { desc = "Toggle file tree" })
map("n", "<leader>r", "<CMD>Neotree reveal<CR>", { desc = "Reveal file in tree" })
-- Oil
map("n", "<leader>E", "<CMD>Oil .<CR>", { desc = "Open parent directory" })
-- Zoxide
map("n", "<leader>z", require("telescope").extensions.zoxide.list, { desc = "Jump to project" })

-- Clear highlights
map("n", "<leader>l", "<CMD>:noh<CR>", { desc = "Clear search highlights" })

-- LSP Telescope
map("n", "<leader>p", "<CMD>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>P", "<CMD>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>b", "<CMD>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>f", "<CMD>Telescope lsp_document_symbols ignore_symbols=namespace,class,constant,variable,property<CR>",
    { desc = "Document symbols" })
map("n", "<leader>F", "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "Workspace symbols" })
map("n", "<leader>h", "<CMD>Telescope help_tags<CR>", { desc = "Search help tags" })
map("n", "<leader>?", "<CMD>WhichKey<CR>", { desc = "Show keymap help" })
map("n", "gd", "<CMD>Telescope lsp_definitions<CR>", { desc = "Go to definition" })
map("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", { desc = "Go to declaration" })
map("n", "gr",
    "<CMD>lua require('telescope.builtin').lsp_references({ on_complete = { function() vim.cmd'stopinsert' end } })<CR>",
    { desc = "Go to references" })
map("n", "gR", "<CMD>lua vim.lsp.buf.rename()<CR>", { desc = "Rename symbol" })
map("n", "gi", "<CMD>Telescope lsp_implementations<CR>", { desc = "Go to implementation" })
map("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", { desc = "Hover documentation" })
map("n", "ga", "<CMD>lua vim.lsp.buf.code_action()<CR>", { desc = "Code actions" })
map("n", "<C-k>", "<CMD>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })
map("n", "gp", "<CMD>lua vim.diagnostic.goto_prev()<CR>", { desc = "Previous diagnostic" })
map("n", "gn", "<CMD>lua vim.diagnostic.goto_next()<CR>", { desc = "Next diagnostic" })
map("n", "gf", "<CMD>lua vim.lsp.buf.format({ async=true })<CR>", { desc = "Format buffer" })
map("v", "gf", "<CMD>lua vim.lsp.buf.range_formatting()<CR>", { desc = "Format selection" })
map("n", "gm", "<CMD>:exec ':setf ' .input('set language: ')<CR>", { desc = "Set filetype" })
map("n", "gC", "<CMD>:CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat" })
map("n", "ma", "<CMD>lua require('telescope').extensions.bookmarks.list()<CR>", { desc = "List bookmarks" })

-- Align
map("v", "=1", ":EasyAlign 1=<CR>", { desc = "Align on first delimiter" })

-- git
map("n", "<leader>gs", "<CMD>:G<CR>", { desc = "Git status" })

-- Airline
map("n", "<leader>1", "<Plug>AirlineSelectTab1", { desc = "Go to tab 1" })
map("n", "<leader>2", "<Plug>AirlineSelectTab2", { desc = "Go to tab 2" })
map("n", "<leader>3", "<Plug>AirlineSelectTab3", { desc = "Go to tab 3" })
map("n", "<leader>4", "<Plug>AirlineSelectTab4", { desc = "Go to tab 4" })
map("n", "<leader>5", "<Plug>AirlineSelectTab5", { desc = "Go to tab 5" })
map("n", "<leader>6", "<Plug>AirlineSelectTab6", { desc = "Go to tab 6" })
map("n", "<leader>7", "<Plug>AirlineSelectTab7", { desc = "Go to tab 7" })
map("n", "<leader>8", "<Plug>AirlineSelectTab8", { desc = "Go to tab 8" })
map("n", "<leader>9", "<Plug>AirlineSelectTab9", { desc = "Go to tab 9" })
print("keymap.lua loaded")

-- K8s
map("n", "<leader>K", "<cmd>lua require('kubectl').toggle()<cr>", { desc = "Toggle kubectl panel" })

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

        map("n", "gr", "<CMD>:Rest run<CR>", { buffer = true, desc = "Run request" })
        map("n", "ge", "<CMD>:Rest env select<CR>", { buffer = true, desc = "Select REST environment" })
        map("n", "go", "<CMD>:Rest open<CR>", { buffer = true, desc = "Open REST result" })
        map("n", "gu", "<CMD>:Rest curl comment<CR>", { buffer = true, desc = "Generate curl comment" })
    end,
})

return {}
