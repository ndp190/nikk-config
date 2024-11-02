require("config.lazy")

-- Load vim_scripts
local vim_files_path = vim.fn.stdpath('config') .. '/vim_scripts/'
local vim_files = vim.fn.globpath(vim_files_path, '*.vim', true, true)
for _, file in ipairs(vim_files) do
    vim.cmd('source ' .. file)
end
