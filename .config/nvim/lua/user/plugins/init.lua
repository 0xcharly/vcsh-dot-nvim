return {
    -- Common dependency.
    { 'nvim-lua/plenary.nvim' },

    -- UI-related plugins.
    { -- Colorscheme.
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = false,
        priority = 100,
        opts = { flavour = 'mocha' },
    },
    { -- Iconography.
        'yamatsum/nvim-nonicons',
        config = true,
        event = 'VeryLazy',
        dependencies = { 'nvim-tree/nvim-web-devicons', config = true },
    },
    { -- Nicer UI primitives.
        'folke/noice.nvim',
        dependencies = 'MunifTanjim/nui.nvim',
        event = 'VeryLazy',
        opts = {
            cmdline = {
                format = {
                    cmdline = { pattern = '^:', icon = ': ', lang = 'vim' },
                    filter = { pattern = '^:%s*!', icon = ' ', lang = 'bash' },
                    help = { pattern = '^:%s*he?l?p?%s+', icon = ' ' },
                    lua = { pattern = '^:%s*lua%s+', icon = ' ', lang = 'lua' },
                },
            },
            messages = {
                enabled = false,
            },
            popupmenu = {
                backend = 'cmp',
            },
            presets = {
                lsp_doc_border = true,
                inc_rename = true,
            },
        },
    },

    --- Motions and other convenience plugins.
    { 'tpope/vim-repeat' },
    { 'tpope/vim-surround' },
    {
        'mbbill/undotree',
        keys = {
            { '<LocalLeader>ut', '<cmd>UndotreeToggle<cr>', desc = '[U]ndo [T]ree' },
        },
    },
    {
        'folke/todo-comments.nvim', opts = {
            highlight = {
                keyword = 'fg',
                pattern = [[.*<(KEYWORDS)(\([a-zA-Z]+\))?\s*:]],
            },
        }
    },
    { 'numToStr/Comment.nvim', lazy = false, config = true },
    { 'ethanholz/nvim-lastplace', lazy = false, config = true },
}
