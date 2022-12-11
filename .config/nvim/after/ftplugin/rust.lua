-- Update this path
local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

local opts = {
    -- ... other configs
    dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    },
}

-- Normal setup
local rt = require "rust-tools"
rt.setup {
    server = {
        -- TODO: figure out why these from lsp-zero get overridden.
        on_attach = function(_, _)
            local fmt = function(cmd)
                return function(str)
                    return cmd:format(str)
                end
            end
            local lsp = fmt "<cmd>lua vim.lsp.%s<cr>"
            local diagnostic = fmt "<cmd>lua vim.diagnostic.%s<cr>"
            local mappings = require "delay.mappings"

            mappings.nnoremap("K", lsp "buf.hover()")
            mappings.nnoremap("gd", lsp "buf.definition()")
            mappings.nnoremap("gD", lsp "buf.declaration()")
            mappings.nnoremap("gi", lsp "buf.implementation()")
            mappings.nnoremap("go", lsp "buf.type_definition()")
            mappings.nnoremap("gr", lsp "buf.references()")
            mappings.nnoremap("<F2>", lsp "buf.rename()")
            mappings.nnoremap("<F4>", lsp "buf.code_action()")
            mappings.xnoremap("<F4>", lsp "buf.range_code_action()")

            mappings.nnoremap("<C-k>", lsp "buf.signature_help()")

            mappings.nnoremap("gl", diagnostic "open_float()")
            mappings.nnoremap("[d", diagnostic "goto_prev()")
            mappings.nnoremap("]d", diagnostic "goto_next()")
        end,
    },
}
