return {
    { -- Language syntaxes.
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = 'BufReadPost',
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter-context' },
            { 'nvim-treesitter/nvim-treesitter-textobjects' },
            { 'JoosepAlviste/nvim-ts-context-commentstring' },
        },
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = {
                    'beancount',
                    'c',
                    'cpp',
                    'dart',
                    'fish',
                    'help',
                    'java',
                    'kotlin',
                    'lua',
                    'markdown',
                    'markdown_inline',
                    'python',
                    'regex',
                    'rst',
                    'rust',
                },
                highlight = { enable = true },
                indent = { enable = true, disable = { 'python' } },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<leader>v', -- maps in normal mode to init the node/scope selection
                        node_incremental = '<leader>v', -- increment to the upper named parent
                        node_decremental = '<leader>V', -- decrement to the previous node
                        scope_incremental = 'grc', -- increment to the upper scope (as defined in locals.scm)
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                            ['aa'] = '@parameter.outer',
                            ['ia'] = '@parameter.inner',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                            ['aC'] = '@conditional.outer',
                            ['iC'] = '@conditional.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ['<leader>a'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['<leader>A'] = '@parameter.inner',
                        },
                    },
                },
            }
        end
    },
    { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' },
}
