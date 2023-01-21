local M = {}

M.diagnostic_signs = {
  Error = ' ',
  Warn = ' ',
  Hint = ' ',
  Info = ' ',
}

-- [[ LSP ]]
-- This function gets run when an LSP connects to a particular buffer.
function M.user_on_attach(_, bufnr)
  -- Disable semantic tokens (overrides tree-sitter highlighting).
  -- client.server_capabilities.semanticTokensProvider = nil

  -- Buffer-specific keymap.
  local buf_opts = { buffer = bufnr }

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, buf_opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, buf_opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, buf_opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, buf_opts)
  vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, buf_opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, buf_opts)
  vim.keymap.set('n', '<LocalLeader>cr', vim.lsp.buf.rename, buf_opts)
  vim.keymap.set('n', '<LocalLeader>cf', function() vim.lsp.buf.format { async = true } end, buf_opts)
  vim.keymap.set('n', '<LocalLeader>ca', vim.lsp.buf.code_action, buf_opts)
  vim.keymap.set('x', '<LocalLeader>ca', vim.lsp.buf.code_action, buf_opts)

  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, buf_opts)

  vim.keymap.set('n', 'gl', vim.diagnostic.open_float, buf_opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, buf_opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, buf_opts)
end

return M
