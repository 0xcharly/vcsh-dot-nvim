local company = require 'user.utils.company'

return {
    {
        'ThePrimeagen/harpoon',
        keys = {
            { '<leader>a', function() require 'harpoon.mark'.add_file() end, silent = true },
            { '<C-e>', function() require 'harpoon.ui'.toggle_quick_menu() end, silent = true },
            { '<c-h>', function() require 'harpoon.ui'.nav_file(1) end, silent = true },
            { '<c-t>', function() require 'harpoon.ui'.nav_file(2) end, silent = true },
            { '<c-n>', function() require 'harpoon.ui'.nav_file(3) end, silent = true },
            { '<c-s>', function() require 'harpoon.ui'.nav_file(4) end, silent = true },
        },
    },

    -- Search engines.
    {
        'nvim-telescope/telescope.nvim',
        lazy = false,
        dependencies = {
            -- 1st-party telescope plugins.
            { 'nvim-telescope/telescope-symbols.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            { 'nvim-telescope/telescope-ui-select.nvim' },

            -- 3rd-party telescope plugins.
            { 'debugloop/telescope-undo.nvim' },
            {
                dir = '~/dev/telescope-codesearch.nvim',
                cond = company.is_corporate_host(),
                config = function()
                    require 'telescope'.load_extension 'codesearch'
                end,
                keys = {
                    {
                        '<LocalLeader>gs',
                        function()
                            require 'telescope'.extensions.codesearch.find_query {}
                        end,
                    },
                    {
                        '<LocalLeader>gf',
                        function()
                            require 'telescope'.extensions.codesearch.find_files {}
                        end,
                    },
                },
            },
        },
        config = function()
            require 'telescope'.setup {
                defaults = {
                    prompt_prefix = '   ',
                    entry_prefix = '   ',
                    selection_caret = ' ❯ ',
                    layout_strategy = 'vertical',

                    file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
                    grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
                    qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,

                    mappings = {
                        i = {
                            ['<esc>'] = require 'telescope.actions'.close,
                            ['<C-x>'] = false,
                            ['<C-q>'] = require 'telescope.actions'.send_to_qflist,
                            ['<CR>'] = require 'telescope.actions'.select_default,
                        },
                    },
                    path_display = function(opts, path)
                        -- Do common substitutions.
                        -- Google3 generic.
                        path = path:gsub('^/google/src/cloud/[^/]+/[^/]+/google3/', 'google3/', 1)
                        path = path:gsub('^google3/java/com/google/', 'g3/jcg/', 1)
                        path = path:gsub('^google3/javatests/com/google/', 'g3/jtcg/', 1)
                        path = path:gsub('^google3/third_party/', 'g3/3rdp/', 1)
                        path = path:gsub('^google3/', 'g3/', 1)

                        -- GMM specific.
                        path = path:gsub('^g3/jcg/apps/android/gmm', 'agmm/', 1)
                        path = path:gsub('^g3/jtcg/apps/android/gmm', 'agmm/tests/', 1)

                        -- Do truncation. This allows us to combine our custom display formatter with the built-in truncation.
                        -- `truncate` handler in transform_path memoizes computed truncation length in opts.__length.
                        -- Here we are manually propagating this value between new_opts and opts.
                        -- We can make this cleaner and more complicated using metatables :)
                        local new_opts = {
                            path_display = {
                                truncate = true,
                            },
                            __length = opts.__length,
                        }
                        path = require 'telescope.utils'.transform_path(new_opts, path)
                        opts.__length = new_opts.__length
                        return path
                    end,
                },
                extensions = {
                    ['ui-select'] = {
                        require 'telescope.themes'.get_dropdown(),
                    },
                },
            }

            require 'telescope'.load_extension 'fzf'
            require 'telescope'.load_extension 'harpoon'
            require 'telescope'.load_extension 'noice'
            require 'telescope'.load_extension 'undo'
            require 'telescope'.load_extension 'ui-select'
        end,
        keys = {
            { '<leader>b', function() require 'telescope.builtin'.buffers() end },
            { '<leader>d', function() require 'telescope.builtin'.diagnostics() end },
            { '<leader>tm', function() require 'telescope.builtin'.man_pages() end },
            { '<LocalLeader>ts', function() require 'telescope.builtin'.lsp_dynamic_workspace_symbols() end },
            { '<leader>su', function() require 'telescope'.extensions.undo.undo() end },
            { '<leader>*', function() require 'telescope.builtin'.grep_string() end },
            { '<leader>/', function() require 'telescope.builtin'.find_files() end },
            { '<leader>?', function() require 'telescope.builtin'.help_tags() end },
        },
    },

    { -- FZF-based fuzzy finder (more responsive).
        'ibhagwan/fzf-lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        keys = {
            { '<leader>ff', function() require 'fzf-lua'.files() end },
            { '<C-p>', function() require 'fzf-lua'.git_files() end },
            { '<leader>g', function() require 'fzf-lua'.live_grep() end },
            {
                '<leader>.',
                function()
                    if vim.fn.executable 'fd' > 0 then
                        require 'fzf-lua'.files { cmd = 'fd . ~/.config --type f' }
                    else
                        require 'fzf-lua'.files { cwd = '~/.config' }
                    end
                end
            },
        },
    },
}
