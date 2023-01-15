return {
    { -- Package manager for LSP/DAP servers, and other tools.
        'williamboman/mason.nvim',
        opts = {
            ensure_installed = {
                'stylua',
                'black',
            },
        },
    },

    { -- Package manager for LSP/DAP servers, and other tools.
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            { 'folke/neodev.nvim', config = true },
            { 'neovim/nvim-lspconfig' },
        },
        config = function()
            -- nvim-cmp supports additional completion capabilities.
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require 'cmp_nvim_lsp'.default_capabilities(capabilities)

            -- Enable (and optionally configure) the following language servers.
            local servers = {
                bashls = {},
                clangd = {},
                cmake = {},
                html = {},
                pylsp = {},
                yamlls = {},
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
                        on_attach = require 'user.utils.lsp'.user_on_attach,
                        settings = servers[server_name],
                    }
                end,
            }

            -- TODO: reenable when ciderlsp is fixed.
            --[[
            -- local company = require 'user.utils.company'
            if company.is_corporate_host() then
                company.setup_lsp(capabilities)
            end
            --]]
        end,
    },

    { -- Enrich Rust development.
        'simrat39/rust-tools.nvim',
        dependencies = { 'mfussenegger/nvim-dap' },
        ft = 'rust',
        opts = {
            server = {
                on_attach = require 'user.utils.lsp'.user_on_attach,
            },
            tools = {
                inlay_hints = { highlight = 'LspCodeLens' },
            },
        },
    },

    { -- Flutter development.
        'akinsho/flutter-tools.nvim',
        ft = 'dart',
        config = true,
    },

    { -- Run formatters.
        'sbdchd/neoformat',
        config = function()
            vim.g.neoformat_enabled_beancount = { 'beanformat' }
            vim.g.neoformat_enabled_python = { 'black' }
        end,
        keys = {
            { '<LocalLeader>bf', '<cmd>Neoformat<cr>', desc = '[F]ormat [B]uffer' },
        },
    },
}
