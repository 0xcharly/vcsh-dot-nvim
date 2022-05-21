return function()
  require('which-key').register({
    t = {
      n = {function() vim.api.nvim_command('CHADopen') end, 'Open file tree'},
      l = {
        function() vim.api.nvim_command('call setqflist([])') end,
        'Clear quickfix list',
      },
    },
  }, {prefix = '<leader>'})
end
