local lsp = require "lsp-zero"
local mappings = require "delay.mappings"

lsp.preset "recommended"

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
        root_dir = function(fname)
            return string.match(fname, "(/google/src/cloud/[%w_-]+/[%w_-]+/google3/).+$")
        end,
        settings = {},
    },
}
lsp.configure("ciderlsp", { force_setup = true })
lsp.on_attach(function(_, bufnr)
    local buf_opts = { buffer = bufnr }
    mappings.nnoremap("<F3>", function()
        vim.lsp.buf.format { async = true }
    end, buf_opts)
end)

lsp.ensure_installed { "clangd", "pylsp", "rust_analyzer", "sumneko_lua", "tsserver" }
lsp.set_preferences {
    suggest_lsp_servers = true,
    setup_servers_on_start = true,
    set_lsp_keymaps = true,
    configure_diagnostics = true,
    cmp_capabilities = true,
    manage_nvim_cmp = true,
    call_servers = "local",
    sign_icons = {
        error = " ",
        warn = " ",
        hint = " ",
        info = " ",
    },
}

lsp.nvim_workspace()

-- Customize CMP mappings.
local cmp = require "cmp"
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mapping = lsp.defaults.cmp_mappings {
    ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm { select = false },
    ["<C-w>"] = cmp.mapping.confirm { select = false },
}
cmp_mapping["<CR>"] = nil
cmp_mapping["<Tab>"] = nil
cmp_mapping["<S-Tab>"] = nil

lsp.setup_nvim_cmp {
    mapping = cmp_mapping,
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,

            -- Copied from cmp-under; don't need a plugin for this.
            function(entry1, entry2)
                local _, entry1_under = entry1.completion_item.label:find "^_+"
                local _, entry2_under = entry2.completion_item.label:find "^_+"
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
}

lsp.setup()

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
