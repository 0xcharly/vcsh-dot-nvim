return function()
  vim.keymap.set('n', '<C-a>', require('dial.map').inc_normal())
  vim.keymap.set('n', '<C-x>', require('dial.map').dec_normal())
  vim.keymap.set('v', '<C-a>', require('dial.map').inc_visual())
  vim.keymap.set('v', '<C-x>', require('dial.map').dec_visual())
  vim.keymap.set('v', 'g<C-a>', require('dial.map').inc_gvisual())
  vim.keymap.set('v', 'g<C-x>', require('dial.map').dec_gvisual())
end
