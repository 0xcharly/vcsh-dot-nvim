local signs = {
    Error = " ",
    Warning = " ",
    Hint = " ",
    Information = " ",
}

for type, icon in pairs(signs) do
    local hl = "LspDiagnosticsSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Mappings.
-- Diagnostic keymaps
local mappings = require "delay.mappings"
mappings.nnoremap("[d", vim.diagnostic.goto_prev)
mappings.nnoremap("]d", vim.diagnostic.goto_next)
mappings.nnoremap("<leader>vd", vim.diagnostic.open_float)

-- Ensure the commonly used servers are installed.
require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "clangd", "rust_analyzer", "pylsp", "tsserver" },
}

local function config(_config)
    return vim.tbl_deep_extend("force", {
        -- nvim-cmp supports additional completion capabilities
        capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        --  This function gets run when an LSP connects to a particular buffer.
        on_attach = function(_, bufnr)
            local buf_opts = { buffer = bufnr }

            mappings.nnoremap("<leader>lr", vim.lsp.buf.rename, buf_opts)
            mappings.nnoremap("<leader>la", vim.lsp.buf.code_action, buf_opts)

            mappings.nnoremap("gd", vim.lsp.buf.definition, buf_opts)
            mappings.nnoremap("gD", vim.lsp.buf.declaration, buf_opts)
            mappings.nnoremap("gi", vim.lsp.buf.implementation, buf_opts)
            mappings.nnoremap("gr", require("telescope.builtin").lsp_references, buf_opts)
            mappings.nnoremap("<leader>ds", require("telescope.builtin").lsp_document_symbols, buf_opts)
            mappings.nnoremap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, buf_opts)

            -- See `:help K` for why this keymap
            mappings.nnoremap("K", vim.lsp.buf.hover, buf_opts)
            mappings.nnoremap("<C-k>", vim.lsp.buf.signature_help, buf_opts)
            mappings.nnoremap("<leader>lf", vim.lsp.buf.format or vim.lsp.buf.formatting, buf_opts)
        end,
    }, _config or {})
end

require("lspconfig").clangd.setup(config())
require("lspconfig").pylsp.setup(config())
require("lspconfig").rust_analyzer.setup(config())
require("lspconfig").tsserver.setup(config())

-- Custom configuration for lua
--
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").sumneko_lua.setup(config {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT)
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                globals = { "vim" },
            },
            -- Make the server aware of Neovim runtime files.
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        },
    },
})

-- Custom configuration for CiderLSP.
require("lspconfig.configs").ciderlsp = {
    default_config = {
        cmd = {
            vim.fn.expand "~/.local/bin/ciderlsp",
            "--tooltag=nvim-lsp",
            "--noforward_sync_responses",
            "--hub_addr=blade:languageservices-staging",
        },
        filetypes = {
            "c",
            "cpp",
            "java",
            "kotlin",
            "proto",
            "textproto",
            "go",
            "python",
            "bzl",
            "objc",
            "typescript",
            "javascript",
        },
        root_dir = function(fname)
            return string.match(fname, "(/google/src/cloud/[%w_-]+/[%w_-]+/google3/).+$")
        end,
        settings = {},
    },
}

require("lspconfig").ciderlsp.setup(config())
require("fidget").setup {
    text = {
        spinner = "dots",
    },
    align = {
        bottom = true,
    },
    window = {
        relative = "editor",
    },
}
