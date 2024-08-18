return {
    {
        'tpope/vim-fugitive',
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
