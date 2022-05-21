return function()
  -- Moving between splits.
  vim.keymap.set('n', '<Left>', require('smart-splits').move_cursor_left)
  vim.keymap.set('n', '<Down>', require('smart-splits').move_cursor_down)
  vim.keymap.set('n', '<Up>', require('smart-splits').move_cursor_up)
  vim.keymap.set('n', '<Right>', require('smart-splits').move_cursor_right)
  -- Resizing splits.
  vim.keymap.set('n', '<C-Left>', require('smart-splits').resize_left)
  vim.keymap.set('n', '<C-Down>', require('smart-splits').resize_down)
  vim.keymap.set('n', '<C-Up>', require('smart-splits').resize_up)
  vim.keymap.set('n', '<C-Right>', require('smart-splits').resize_right)
end
