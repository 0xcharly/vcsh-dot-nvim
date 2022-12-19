local mappings = require("delay.mappings")

local M = {}

-- nvim-cmp supports additional completion capabilities
M.capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- This function gets run when an LSP connects to a particular buffer.
M.on_attach = function(_, bufnr)
    local buf_opts = { buffer = bufnr }

    mappings.nnoremap("K", vim.lsp.buf.hover, buf_opts)
    mappings.nnoremap("gd", vim.lsp.buf.definition, buf_opts)
    mappings.nnoremap("gD", vim.lsp.buf.declaration, buf_opts)
    mappings.nnoremap("gi", vim.lsp.buf.implementation, buf_opts)
    mappings.nnoremap("go", vim.lsp.buf.type_definition, buf_opts)
    mappings.nnoremap("gr", vim.lsp.buf.references, buf_opts)
    mappings.nnoremap("<LocalLeader>cr", vim.lsp.buf.rename, buf_opts)
    mappings.nnoremap("<LocalLeader>cf", function() vim.lsp.buf.format({ async = true }) end, buf_opts)
    mappings.nnoremap("<LocalLeader>ca", vim.lsp.buf.code_action, buf_opts)
    mappings.xnoremap("<LocalLeader>ca", vim.lsp.buf.range_code_action, buf_opts)

    mappings.nnoremap("<C-k>", vim.lsp.buf.signature_help, buf_opts)

    mappings.nnoremap("gl", vim.diagnostic.open_float, buf_opts)
    mappings.nnoremap("[d", vim.diagnostic.goto_prev, buf_opts)
    mappings.nnoremap("]d", vim.diagnostic.goto_next, buf_opts)
end

M.common_config = function(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = M.capabilities,
        on_attach = M.on_attach,
    }, _config or {})
end

M.setup_nvim_workspace = function()
    -- Custom configuration for lua
    --
    -- Make runtime files discoverable to the server
    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    require("lspconfig").sumneko_lua.setup(M.common_config({
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
    }))
end

return M
