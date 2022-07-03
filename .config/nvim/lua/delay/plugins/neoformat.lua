return function()
  vim.g.neoformat_c_clangformat = {
    exe = 'clang-format',
    args = {'--style=file'},
    stdin = 1,
  }
  vim.g.neoformat_enabled_c = {'clangformat'}
  vim.g.neoformat_cpp_clangformat = {
    exe = 'clang-format',
    args = {'--style=file'},
    stdin = 1,
  }
  vim.g.neoformat_enabled_cpp = {'clangformat'}

  vim.g.neoformat_lua_luaformat = {
    exe = 'lua-format',
    args = {
      '--indent-width=2', '--extra-sep-at-table-end',
      '--double-quote-to-single-quote',
    },
  }
  vim.g.neoformat_enabled_lua = {'luaformat'}

  vim.g.neoformat_enabled_markdown = {'prettier'}
  vim.g.neoformat_enabled_yaml = {'prettier'}

  vim.g.neoformat_enabled_beancount = {'beanformat'}
  vim.g.neoformat_enabled_python = {'black'}

  vim.cmd [[ augroup fmt ]]
  vim.cmd [[ autocmd! ]]
  vim.cmd [[ autocmd BufWritePre *.lua Neoformat ]]
  vim.cmd [[ autocmd BufWritePre *.beancount Neoformat ]]
  vim.cmd [[ autocmd BufWritePre *.py Neoformat ]]
  vim.cmd [[ autocmd BufWritePre *.c,*.h,*.cc,*.hh,*.cpp,*.hpp Neoformat ]]
  vim.cmd [[ autocmd BufWritePre *.md,*.yaml,*.yml Neoformat ]]
  vim.cmd [[ augroup END ]]
end
