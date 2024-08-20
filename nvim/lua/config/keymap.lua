vim.g.mapleader = " "

-- mg979/vim-visual-multi key mappings
vim.g.VM_maps = {
  ["Find Under"] = "<C-g>", -- normal mode multicursor
  ["Find Subword Under"] = "<C-g>", -- visual mode multicursor
}

local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { silent = true })
end

vim.api.nvim_create_user_command('ToggleRelativeNumber', function()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, {})

map("n", "=3", "<CMD>:ToggleRelativeNumber<CR>")

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
map("n", "gr", "<CMD>lua require('telescope.builtin').lsp_references({ on_complete = { function() vim.cmd'stopinsert' end } })<CR>")
map("n", "gR", "<CMD>lua vim.lsp.buf.rename()<CR>")
map("n", "gi", "<CMD>Telescope lsp_implementations<CR>")
map("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>")
map("n", "ga", "<CMD>lua vim.lsp.buf.code_action()<CR>")
map("n", "<C-k>", "<CMD>lua vim.lsp.buf.signature_help()<CR>")
map("n", "gp", "<CMD>lua vim.lsp.diagnostic.goto_prev()<CR>")
map("n", "gn", "<CMD>lua vim.lsp.diagnostic.goto_next()<CR>")
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
