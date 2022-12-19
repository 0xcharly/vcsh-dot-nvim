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
local rt = require("rust-tools")
rt.setup({
    server = {
        on_attach = require("user.lsp").on_attach,
    },
    tools = {
        inlay_hints = {
            highlight = "@hint.inlay", -- The color of the hints
        },
    },
})
