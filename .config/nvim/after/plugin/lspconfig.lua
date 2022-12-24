local lsp = require("user.lsp")
local lsp_config = require("lspconfig")

-- UI setup.
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})

local signs = {
    Error = "",
    Warn = "▲",
    Hint = "",
    Info = "",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

-- Ensure the commonly used servers are installed.
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "clangd", "pylsp", "rust_analyzer", "sumneko_lua", "tsserver" },
})

-- Custom configuration for CiderLSP.
require("lspconfig.configs").ciderlsp = {
    default_config = {
        cmd = {
            "/google/bin/releases/cider/ciderlsp/ciderlsp",
            "--tooltag=nvim-lsp",
            "--noforward_sync_responses",
            "--websocket_host=ciderlsp-staging.corp.google.com",
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
        root_dir = function(fname) return string.match(fname, "(/google/src/cloud/[%w_-]+/[%w_-]+/google3/).+$") end,
        settings = {},
    },
}

-- Setup common LSP servers.
lsp_config.clangd.setup(lsp.common_config())
lsp_config.pylsp.setup(lsp.common_config())
lsp_config.rust_analyzer.setup(lsp.common_config())
lsp_config.tsserver.setup(lsp.common_config())
lsp_config.ciderlsp.setup(lsp.common_config())

-- Add-ons for Lua in Neovim.
lsp.setup_nvim_workspace()
