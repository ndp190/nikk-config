return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "modern",
            delay = 250,
            notify = false,
            win = {
                border = "rounded",
                padding = { 1, 2 },
            },
            layout = {
                width = { min = 24, max = 64 },
                spacing = 3,
            },
            icons = {
                mappings = false,
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.add({
                { "<leader>g", group = "git" },
                { "<leader>N", group = "actions" },
                { "<leader>Na", desc = "Open custom actions" },
                { "<leader>?", desc = "Show keymap help" },
                { "<leader>lg", desc = "Open LazyGit" },
                { "<C-t>", desc = "Toggle terminal" },
                { "<C-a>", desc = "Toggle Claude terminal" },
                { "g", group = "goto" },
                { "m", group = "marks" },
                { "=", group = "toggles" },
            })
        end,
    },
}
