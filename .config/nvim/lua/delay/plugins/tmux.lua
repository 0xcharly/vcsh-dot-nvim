return function()
  opts = {silent = true, noremap = true}
  vim.api.nvim_set_keymap('n', '<C-up>',
                          [[<cmd>lua require'tmux'.move_up()<CR>]], opts)
  vim.api.nvim_set_keymap('n', '<C-down>',
                          [[<cmd>lua require'tmux'.move_down()<CR>]], opts)
  vim.api.nvim_set_keymap('n', '<C-left>',
                          [[<cmd>lua require'tmux'.move_left()<CR>]], opts)
  vim.api.nvim_set_keymap('n', '<C-right>',
                          [[<cmd>lua require'tmux'.move_right()<CR>]], opts)
  require('which-key').register({
    w = {
      h = {function() require('tmux').move_left() end, 'window-left'},
      t = {function() require('tmux').move_down() end, 'window-bottom'},
      c = {function() require('tmux').move_up() end, 'window-top'},
      n = {function() require('tmux').move_right() end, 'window-right'},
    },
  }, {prefix = '<leader>'})
end
