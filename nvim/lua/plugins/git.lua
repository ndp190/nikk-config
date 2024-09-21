return {
    {
        'tpope/vim-fugitive',
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        dependencies = {
            -- github support :Gbrowse
            'tpope/vim-rhubarb'
        },
    },
    {
        'airblade/vim-gitgutter',
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    },
}
