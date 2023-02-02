-- UI-related plugins.

return {
  { -- Colorscheme: Coalescence
    '0xcharly/coalescence.nvim',
    dependencies = { 'tjdevries/colorbuddy.nvim' },
    dev = true,
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      require 'colorbuddy'.colorscheme 'coalescence'
    end,
  },

  -- Iconography.
  { 'nvim-tree/nvim-web-devicons', config = true },

  { -- Nicer UI primitives.
    'folke/noice.nvim',
    dependencies = 'MunifTanjim/nui.nvim',
    event = 'VeryLazy',
    opts = {
      cmdline = {
        format = {
          cmdline = { pattern = '^:', icon = ': ', lang = 'vim' },
          filter = { pattern = '^:%s*!', icon = ' ', lang = 'bash' },
          help = { pattern = '^:%s*he?l?p?%s+', icon = ' ' },
          lua = { pattern = '^:%s*lua%s+', icon = ' ', lang = 'lua' },
        },
      },
      messages = {
        enabled = true,
        view_search = false,
      },
      popupmenu = {
        backend = 'cmp',
      },
      presets = {
        lsp_doc_border = true,
        inc_rename = true,
      },
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
    },
  },

  {
    'nvim-lualine/lualine.nvim',
    config = true,
  },

  { 'lewis6991/gitsigns.nvim', config = true },

  {
    'folke/trouble.nvim',
    config = function()
      local signs = require 'user.utils.lsp'.diagnostic_signs
      require 'trouble'.setup {
        signs = {
          error = signs.Error,
          warning = signs.Warn,
          hint = signs.Hint,
          information = signs.Info,
          other = '﫠',
        },
      }
    end,
  },

  { -- Scrollbar.
    'petertriho/nvim-scrollbar',
    event = 'BufReadPost',
    config = true,
  },

  { -- Better folds.
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    event = 'BufReadPost',
    config = true,

    init = function()
      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zO', function() require 'ufo'.openAllFolds() end)
      vim.keymap.set('n', 'zC', function() require 'ufo'.closeAllFolds() end)
    end,
  },
}
