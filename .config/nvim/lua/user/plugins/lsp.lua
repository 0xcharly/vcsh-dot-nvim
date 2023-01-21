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
      'neovim/nvim-lspconfig',
      dependencies = { 'folke/neodev.nvim', config = true },
    },
    config = function()
      -- nvim-cmp supports additional completion capabilities.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      capabilities.textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      }

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
      require('mason').setup { ui = { border = 'rounded', check_outdated_packages_on_open = true } }

      local mason_lspconfig = require 'mason-lspconfig'
      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = require('user.utils.lsp').user_on_attach,
            settings = servers[server_name],
          }
        end,
      }

      --[[ TODO: reenable when ciderlsp is fixed.
      -- local company = require 'user.utils.company'
      if company.is_corporate_host() then
        company.setup_lsp(capabilities)
      end
      --]]

      -- Leading icon on diagnostic virtual text.
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        -- This sets the spacing and the prefix, obviously.
        virtual_text = {
          spacing = 4,
          prefix = ' ',
        },
      })

      local signs = require('user.utils.lsp').diagnostic_signs
      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  },

  { -- Enrich Rust development.
    'simrat39/rust-tools.nvim',
    dependencies = { 'mfussenegger/nvim-dap' },
    ft = 'rust',
    opts = {
      server = {
        on_attach = require('user.utils.lsp').user_on_attach,
      },
      tools = {
        inlay_hints = { highlight = 'LspCodeLens' },
      },
    },
  },

  { -- Enrich Flutter development.
    'akinsho/flutter-tools.nvim',
    ft = 'dart',
    opts = {
      decorations = {
        statusline = {
          app_version = true,
          device = true,
        },
      },
      lsp = {
        on_attach = require('user.utils.lsp').user_on_attach,
      },
    },
  },

  { -- Incremental LSP rename.
    'smjonas/inc-rename.nvim',
    cmd = 'IncRename',
    config = true,
    keys = {
      { '<LocalLeader>bf', '<cmd>Increname<cr>', desc = '[R]ename ([B]uffer)' },
    },
  },

  { -- Run formatters.
    'sbdchd/neoformat',
    config = function()
      vim.g.neoformat_enabled_beancount = { 'beanformat' }
      vim.g.neoformat_enabled_python = { 'black' }
    end,
    keys = {
      { '<LocalLeader>bf', '<cmd>Neoformat<cr>', desc = '[F]ormat ([B]uffer)' },
    },
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local nls = require 'null-ls'
      nls.setup {
        debounce = 150,
        save_after_format = false,
        sources = {
          -- nls.builtins.formatting.prettierd,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.fish_indent,
          -- nls.builtins.formatting.fixjson.with({ filetypes = { "jsonc" } }),
          -- nls.builtins.diagnostics.shellcheck,
          nls.builtins.formatting.jq,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.bean_format,
          nls.builtins.formatting.mdformat,
          nls.builtins.diagnostics.markdownlint,
          nls.builtins.diagnostics.fish,
          -- nls.builtins.diagnostics.luacheck,
          nls.builtins.diagnostics.selene,
          nls.builtins.formatting.prettierd.with {
            filetypes = { 'markdown' }, -- only runs `deno fmt` for markdown
          },
          -- nls.builtins.code_actions.gitsigns,
          nls.builtins.formatting.isort,
          nls.builtins.formatting.black,
          nls.builtins.diagnostics.flake8,
        },
        root_dir = require('null-ls.utils').root_pattern('.null-ls-root', '.neoconf.json', '.git'),
      }
    end,
  },
}
