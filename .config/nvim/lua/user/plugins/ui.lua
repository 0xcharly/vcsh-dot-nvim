-- UI-related plugins.

return {
    { -- Colorscheme: Coalescence
        '0xcharly/coalescence.nvim',
        dependencies = { 'tjdevries/colorbuddy.nvim' },
        dev = true,
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.termguicolors = true
            require 'colorbuddy'.colorscheme 'coalescence'
        end,
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
            lsp = {
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true,
                },
            },
        },
    },
    { -- Scrollbar.
        'petertriho/nvim-scrollbar',
        event = 'BufReadPost',
        opts = {
            excluded_filetypes = { 'prompt', 'TelescopePrompt', 'noice', 'notify' },
        },
    },
}
