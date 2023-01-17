return {
    -- Common dependency.
    { 'nvim-lua/plenary.nvim' },

    --- Motions and other convenience plugins.
    { 'tpope/vim-repeat' },
    { 'tpope/vim-surround' },
    {
        'mbbill/undotree',
        keys = {
            { '<LocalLeader>ut', '<cmd>UndotreeToggle<cr>', desc = '[U]ndo [T]ree' },
        },
    },
    { 'asiryk/auto-hlsearch.nvim', event = 'BufReadPost', config = true },
    { 'numToStr/Comment.nvim', lazy = false, config = true },
    { 'ethanholz/nvim-lastplace', lazy = false, config = true },
}
