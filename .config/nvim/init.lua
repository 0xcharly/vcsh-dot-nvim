-- Bootstrap package manager.
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- [[ LSP ]]
-- This function gets run when an LSP connects to a particular buffer.
local function user_on_attach(_, bufnr)
    local buf_opts = { buffer = bufnr }

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, buf_opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, buf_opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, buf_opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, buf_opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, buf_opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, buf_opts)
    vim.keymap.set('n', '<LocalLeader>cr', vim.lsp.buf.rename, buf_opts)
    vim.keymap.set('n', '<LocalLeader>cf', function()
        vim.lsp.buf.format { async = true }
    end, buf_opts)
    vim.keymap.set('n', '<LocalLeader>ca', vim.lsp.buf.code_action, buf_opts)
    vim.keymap.set('x', '<LocalLeader>ca', vim.lsp.buf.code_action, buf_opts)

    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, buf_opts)

    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, buf_opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, buf_opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, buf_opts)
end

-- [[ Company ]]
local google3_home = '/google/src/cloud/delay/'
local google3_filetype_group = vim.api.nvim_create_augroup('Google3Filetype', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    group = google3_filetype_group,
    pattern = { google3_home .. '*.java', google3_home .. '*.kt' },
    command = 'set sw=2 ts=2 sts=2 tw=100',
})

local plugins_spec = {
    -- Common dependency.
    { 'nvim-lua/plenary.nvim' },

    -- UI-related plugins.
    { -- Colorscheme.
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = false,
        priority = 100,
        config = {
            flavour = 'mocha',
            -- custom_highlights = function(colors)
            --     return {
            --         ['@hint.inlay'] = { fg = colors.surface1, style = { 'italic' } },
            --     }
            -- end,
        }
    },
    { -- Iconography.
        'yamatsum/nvim-nonicons',
        config = true,
        event = 'VeryLazy',
        dependencies = { 'nvim-tree/nvim-web-devicons', config = true },
    },
    { -- Nicer UI primitives.
        'folke/noice.nvim', dependencies = 'MunifTanjim/nui.nvim', event = 'VeryLazy', config = {
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
        'ThePrimeagen/harpoon', keys = {
            { '<leader>a', function() require 'harpoon.mark'.add_file() end, silent = true },
            { '<C-e>', function() require 'harpoon.ui'.toggle_quick_menu() end, silent = true },
            { '<c-h>', function() require 'harpoon.ui'.nav_file(1) end, silent = true },
            { '<c-t>', function() require 'harpoon.ui'.nav_file(2) end, silent = true },
            { '<c-n>', function() require 'harpoon.ui'.nav_file(3) end, silent = true },
            { '<c-s>', function() require 'harpoon.ui'.nav_file(4) end, silent = true },
        }
    },
    {
        'mbbill/undotree',
        keys = {
            { '<LocalLeader>ut', '<cmd>UndotreeShow<cr>', desc = '[U]ndo [T]ree' },
        },
    },
    { 'numToStr/Comment.nvim', lazy = false, config = true },
    { 'ethanholz/nvim-lastplace', lazy = false, config = true },

    { -- Language syntaxes.
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = 'BufReadPost',
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter-context' },
            { 'nvim-treesitter/nvim-treesitter-textobjects' },
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

    { -- Package manager for LSP/DAP servers, and other tools.
        'williamboman/mason.nvim',
        dependencies = {
            { 'folke/neodev.nvim', config = true },
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        cmd = 'Mason',
        ft = { 'c', 'cpp', 'lua', 'python', 'rust' },
        config = function()
            -- nvim-cmp supports additional completion capabilities.
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require 'cmp_nvim_lsp'.default_capabilities(capabilities)

            -- Enable (and optionally configure) the following language servers.
            local servers = {
                clangd = {},
                pylsp = {},
                rust_analyzer = {},

                sumneko_lua = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                        format = {
                            enable = true,
                            defaultConfig = {
                                call_arg_parentheses = 'remove',
                                indent_style = 'space',
                                quote_style = 'single',
                            },
                        },
                    },
                },
            }

            -- Ensure the commonly used servers are installed.
            require 'mason'.setup { ui = { border = 'rounded', check_outdated_packages_on_open = true } }

            local mason_lspconfig = require 'mason-lspconfig'
            mason_lspconfig.setup {
                ensure_installed = vim.tbl_keys(servers),
            }

            mason_lspconfig.setup_handlers {
                function(server_name)
                    require 'lspconfig'[server_name].setup {
                        capabilities = capabilities,
                        on_attach = user_on_attach,
                        settings = servers[server_name],
                    }
                end,
            }
        end
    },

    { -- Enrich Rust development.
        'simrat39/rust-tools.nvim',
        dependencies = { 'mfussenegger/nvim-dap' },
        ft = 'rust',
        config = {
            server = {
                on_attach = user_on_attach,
                -- TODO: remove once #307 is merged.
                -- https://github.com/simrat39/rust-tools.nvim/pull/307
                settings = {
                    ['rust-analyzer'] = {
                        inlayHints = { locationLinks = false },
                    },
                },
            },
            tools = {
                inlay_hints = {
                    -- highlight = '@hint.inlay', -- The color of the hints
                    highlight = 'LspCodeLens', -- The color of the hints
                },
            },
        },
    },

    { -- Completion engine.
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            { 'L3MON4D3/LuaSnip' },
            { 'onsails/lspkind.nvim' },
        },
        config = function()
            local cmp = require 'cmp'

            cmp.setup {
                mapping = cmp.mapping.preset.insert {
                    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                        { 'i', 'c' }),
                    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                        { 'i', 'c' }),
                    ['<C-w>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-m>'] = cmp.mapping.scroll_docs(4),
                    ['<C-a>'] = cmp.mapping.abort(),
                    ['<C-y>'] = cmp.mapping(
                        cmp.mapping.confirm {
                            behavior = cmp.ConfirmBehavior.Insert,
                            select = true,
                        },
                        { 'i', 'c' }
                    ),
                    ['<c-space>'] = cmp.mapping.complete {},
                    ['<C-q>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
                    ['<Tab>'] = cmp.config.disable,
                },
                sources = {
                    { name = 'nvim_lua' },
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'luasnip' },
                    { name = 'buffer', keyword_length = 5 },
                },
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,

                        -- Copied from cmp-under; don't need a plugin for this.
                        function(entry1, entry2)
                            local _, entry1_under = entry1.completion_item.label:find '^_+'
                            local _, entry2_under = entry2.completion_item.label:find '^_+'
                            entry1_under = entry1_under or 0
                            entry2_under = entry2_under or 0
                            if entry1_under > entry2_under then
                                return false
                            elseif entry1_under < entry2_under then
                                return true
                            end
                        end,

                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                snippet = {
                    expand = function(args)
                        require 'luasnip'.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                formatting = {
                    format = require 'lspkind'.cmp_format {
                        mode = 'symbol_text',
                        preset = 'codicons',
                        maxwidth = 50,
                        ellipsis_char = '…',
                        menu = {
                            buffer = ' (buf)',
                            nvim_lsp = ' (lsp)',
                            nvim_lua = ' (lua)',
                        },
                    },
                },
            }

            -- Use buffer source for `/`.
            cmp.setup.cmdline('/', { sources = { { name = 'buffer' } } })

            -- Use cmdline & path source for ':'.
            cmp.setup.cmdline(':', {
                sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
            })

            cmp.setup.filetype('beancount', {
                sources = cmp.config.sources { { name = 'beancount' } },
            })
        end
    },
    { 'crispgm/cmp-beancount', ft = 'beancount' },

    -- Search engines.
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        dependencies = {
            -- 1st-party telescope plugins.
            { 'nvim-telescope/telescope-symbols.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

            -- 3rd-party telescope plugins.
            { 'debugloop/telescope-undo.nvim' },
            {
                'telescope-codesearch.nvim',
                dev = true,
                cond = vim.loop.fs_stat(google3_home) ~= nil,
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
            }

            pcall(require 'telescope'.load_extension, 'fzf')
            pcall(require 'telescope'.load_extension, 'harpoon')
            pcall(require 'telescope'.load_extension, 'undo')
        end,
        keys = {
            { '<leader>b', function() require 'telescope.builtin'.buffers() end },
            { '<leader>d', function() require 'telescope.builtin'.diagnostics() end },
            { '<leader>tm', function() require 'telescope.builtin'.man_pages() end },
            { '<leader>ts', function() require 'telescope.builtin'.lsp_dynamic_workspace_symbols() end },
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

    { -- Run formatters.
        'sbdchd/neoformat',
        config = function()
            vim.g.neoformat_c_clangformat = {
                exe = 'clang-format',
                args = { '--style=file' },
                stdin = 1,
            }
            vim.g.neoformat_enabled_c = { 'clangformat' }
            vim.g.neoformat_cpp_clangformat = {
                exe = 'clang-format',
                args = { '--style=file' },
                stdin = 1,
            }
            vim.g.neoformat_enabled_cpp = { 'clangformat' }

            vim.g.neoformat_enabled_beancount = { 'beanformat' }
            vim.g.neoformat_enabled_python = { 'black' }
        end,
        keys = {
            { '<LocalLeader>bf', '<cmd>Neoformat<cr>', desc = '[F]ormat [B]uffer' },
        },
    },
}

-- Set global leader key.
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

require 'lazy'.setup(plugins_spec, {
    dev = {
        path = '~/dev',
    },
    ui = {
        border = 'rounded',
    },
    performance = {
        rtp = {
            disabled_plugins = {
                'health',
                'gzip',
                'matchit',
                'matchparen',
                -- 'netrwPlugin',
                'rplugin',
                'shada',
                'spellfile',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
})

-- Colorscheme.
vim.o.termguicolors = true
vim.cmd.colorscheme 'catppuccin'

-- Netrw plugin.
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Mouse support.
vim.o.mouse = 'a'

-- No horizontal scroll.
vim.keymap.set('n', '<ScrollWheelLeft>', '<Nop>', { silent = true })
vim.keymap.set('n', '<ScrollWheelRight>', '<Nop>', { silent = true })

-- Window appearance.
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'

vim.o.breakindent = true
vim.o.undofile = true
vim.o.belloff = 'all'

-- Indentation.
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.textwidth = 80
vim.o.wrap = false

-- Search.
vim.o.incsearch = true
vim.o.ignorecase = true -- Ignore case when searching...
vim.o.smartcase = true -- ... unless there is a capital letter in the query
vim.o.splitright = true -- Prefer windows splitting to the right
vim.o.splitbelow = true -- Prefer windows splitting to the bottom
vim.o.updatetime = 50 -- Make updates happen faster
vim.o.scrolloff = 8 -- Make it so there are always 8 lines below my cursor

vim.opt.formatoptions = vim.opt.formatoptions -- :h fo
    - 'a' -- Auto formatting is BAD.
    - 't' -- Don't auto format my code. I got linters for that.
    + 'q' -- continue comments with gq'.
    + 'c' -- Auto-wrap comments using textwidth.
    - 'o' -- O and o, don't continue comments.
    + 'r' -- But do continue when pressing enter.
    + 'n' -- Indent past the formatlistpat, not underneath it.
    + 'j' -- Auto-remove comments if possible.
    - '2' -- Use indent from 2nd line of a paragraph.

-- Message output.
vim.opt.shortmess = {
    t = true, -- truncate file messages at start
    a = true, -- ignore annoying save file messages
    A = true, -- ignore annoying swap file messages
    o = true, -- file-read message overwrites previous
    O = true, -- file-read message overwrites previous
    T = true, -- truncate non-file messages in middle
    f = true, -- (file x of x) instead of just (x of x
    F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
    s = true,
    c = true,
    W = true, -- Dont show [w] or written when writing
}

-- Keymaps for better default experience.
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Use faster grep alternatives if possible.
if vim.fn.executable 'rg' > 0 then
    vim.o.grepprg = [[rg --hidden --glob '!.git' --no-heading --smart-case --vimgrep --follow $*]]
    vim.opt.grepformat = vim.opt.grepformat ^ { '%f:%l:%c:%m' }
elseif vim.fn.executable 'ag' > 0 then
    vim.o.grepprg = [[ag --nogroup --nocolor --vimgrep]]
    vim.opt.grepformat = vim.opt.grepformat ^ { '%f:%l:%c:%m' }
end

-- [[ Flash on yank ]]
-- See `:help vim.highlight.on_yank()`
local yank_group = vim.api.nvim_create_augroup('HighlightYank', {})
vim.api.nvim_create_autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank {
            higroup = 'IncSearch',
            timeout = 40,
        }
    end,
})

-- [[ Remove trailing whitespaces ]]
local whitespace_group = vim.api.nvim_create_augroup('WhitespaceGroup', {})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = whitespace_group,
    pattern = '*',
    command = '%s/\\s\\+$//e',
})

-- [[ Key bindings ]]
local keymap_opts = { silent = true }

-- Diagnostic keymaps.
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, keymap_opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, keymap_opts)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, keymap_opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, keymap_opts)

-- To use `ALT+{h,j,k,l}` to navigate windows from any mode:
vim.keymap.set('t', '<M-Left>', '<C-\\><C-N><C-w>h', keymap_opts)
vim.keymap.set('t', '<M-Down>', '<C-\\><C-N><C-w>j', keymap_opts)
vim.keymap.set('t', '<M-Up>', '<C-\\><C-N><C-w>k', keymap_opts)
vim.keymap.set('t', '<M-Right>', '<C-\\><C-N><C-w>l', keymap_opts)

-- Make esc leave terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', keymap_opts)

-- Try and make sure to not mangle space items
vim.keymap.set('t', '<S-Space>', '<Space>', keymap_opts)
vim.keymap.set('t', '<C-Space>', '<Space>', keymap_opts)

vim.keymap.set('i', '<M-Left>', '<C-\\><C-N><C-w>h', keymap_opts)
vim.keymap.set('i', '<M-Down>', '<C-\\><C-N><C-w>j', keymap_opts)
vim.keymap.set('i', '<M-Up>', '<C-\\><C-N><C-w>k', keymap_opts)
vim.keymap.set('i', '<M-Right>', '<C-\\><C-N><C-w>l', keymap_opts)
vim.keymap.set('n', '<M-Left>', '<C-w>h', keymap_opts)
vim.keymap.set('n', '<M-Down>', '<C-w>j', keymap_opts)
vim.keymap.set('n', '<M-Up>', '<C-w>k', keymap_opts)
vim.keymap.set('n', '<M-Right>', '<C-w>l', keymap_opts)

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.keymap.set('v', 'J', ":m '>+1<cr>gv=gv", keymap_opts)
vim.keymap.set('v', 'K', ":m '<-2<cr>gv=gv", keymap_opts)

vim.keymap.set('n', 'Y', 'yg$', keymap_opts)
vim.keymap.set('n', 'n', 'nzzzv', keymap_opts)
vim.keymap.set('n', 'N', 'Nzzzv', keymap_opts)
vim.keymap.set('n', 'J', 'mzJ`z', keymap_opts)
vim.keymap.set('n', '<C-d>', '<C-d>zz', keymap_opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', keymap_opts)

-- Better virtual paste.
vim.keymap.set('x', '<leader>p', '"_dP', keymap_opts)
vim.keymap.set('i', '<C-v>', '<C-o>"+p', keymap_opts)
vim.keymap.set('c', '<C-v>', '<C-r>+', keymap_opts)

-- Better yank.
vim.keymap.set('n', '<leader>y', '"+y', keymap_opts)
vim.keymap.set('v', '<leader>y', '"+y', keymap_opts)
vim.keymap.set('n', '<leader>Y', '"+Y', keymap_opts)

-- Better delete.
vim.keymap.set('n', '<leader>d', '"_d', keymap_opts)
vim.keymap.set('v', '<leader>d', '"_d', keymap_opts)

-- Better jumps.
vim.keymap.set('n', '<C-k>', '<cmd>cnext<cr>zz', keymap_opts)
vim.keymap.set('n', '<C-j>', '<cmd>cprev<cr>zz', keymap_opts)
vim.keymap.set('n', '<leader>k', '<cmd>lnext<cr>zz', keymap_opts)
vim.keymap.set('n', '<leader>j', '<cmd>lprev<cr>zz', keymap_opts)

-- Tools integration.
vim.keymap.set('n', '<c-f>', '<cmd>!tmux new-window ~/.local/bin/open-tmux-workspace<cr>', keymap_opts)

-- TODO: re-enable this.
-- Custom configuration for CiderLSP.
--[[
require 'lspconfig.configs'.ciderlsp = {
    default_config = {
        cmd = {
            '/google/bin/releases/cider/ciderlsp/ciderlsp',
            '--tooltag=nvim-lsp',
            '--noforward_sync_responses',
            '--websocket_host=ciderlsp-staging.corp.google.com',
        },
        filetypes = {
            'c',
            'cpp',
            'java',
            'kotlin',
            'proto',
            'textproto',
            'go',
            'python',
            'bzl',
            'objc',
            'typescript',
            'javascript',
        },
        root_dir = function(fname)
            return string.match(fname, '(/google/src/cloud/[%w_-]+/[%w_-]+/google3/).+$')
        end,
        settings = {},
    },
}
require 'lspconfig'.ciderlsp.setup {
    capabilities = capabilities,
    on_attach = user_on_attach,
}
--]]
