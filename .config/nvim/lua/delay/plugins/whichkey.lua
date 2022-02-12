return function()
  local wk = require 'which-key'

  wk.setup({
    key_labels = {
      ['<cr>'] = 'RET',
      ['<leader>'] = 'SPC',
      ['<space>'] = 'SPC',
      ['<tab>'] = 'TAB',
    },
    triggers = 'auto',
  })

  local leader = {
    w = {
      name = '+windows',
      ['w'] = {'<C-W>p', 'other-window'},
      ['d'] = {'<C-W>c', 'delete-window'},
      ['-'] = {'<C-W>s', 'split-window-below'},
      ['|'] = {'<C-W>v', 'split-window-right'},
      ['2'] = {'<C-W>v', 'layout-double-columns'},
      -- Handled by the Tmux plugin.
      -- ['h'] = {'<C-W>h', 'window-left'},
      -- ['t'] = {'<C-W>j', 'window-below'},
      -- ['n'] = {'<C-W>l', 'window-right'},
      -- ['c'] = {'<C-W>k', 'window-up'},
      ['H'] = {'<C-W>5<', 'expand-window-left'},
      ['T'] = {
        function() vim.api.nvim_command('resize +5') end, 'expand-window-below',
      },
      ['N'] = {'<C-W>5>', 'expand-window-right'},
      ['C'] = {
        function() vim.api.nvim_command('resize -5') end, 'expand-window-up',
      },
      ['='] = {'<C-W>=', 'balance-window'},
      ['s'] = {'<C-W>s', 'split-window-below'},
      ['v'] = {'<C-W>v', 'split-window-right'},
    },
    p = {
      name = '+packer',
      c = {function() vim.api.nvim_command('PackerClean') end, 'Clean'},
      i = {function() vim.api.nvim_command('PackerInstall') end, 'Install'},
      r = {function() vim.api.nvim_command('PackerCompile') end, 'Compile'},
      s = {function() vim.api.nvim_command('PackerSync') end, 'Sync'},
    },
    q = {
      name = '+quit',
      q = {function() vim.api.nvim_command('qa') end, 'Quit'},
      ['!'] = {
        function() vim.api.nvim_command('qa!') end, 'Quit (without saving)',
      },
    },
    g = 'Grep word under the cursor',
    o = {name = '+only', n = 'Close all other buffers'},
    ['<space>'] = {
      name = 'workspace',
      c = {function() vim.api.nvim_command('tabnew') end, 'New'},
      d = {function() vim.api.nvim_command('tabclose') end, 'Close'},
      f = {function() vim.api.nvim_command('tabfirst') end, 'First'},
      l = {function() vim.api.nvim_command('tablast') end, 'Last'},
      n = {function() vim.api.nvim_command('tabnext') end, 'Next'},
      p = {function() vim.api.nvim_command('tabprevious') end, 'Previous'},
    },
  }

  for i = 0, 10 do leader[tostring(i)] = 'which_key_ignore' end

  wk.register(leader, {prefix = '<leader>'})
end
