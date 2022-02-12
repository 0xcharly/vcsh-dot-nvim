return function()
  local fill_highlight = {highlight = 'BufferLineFill', attribute = 'bg'}
  local buffer_inactive_guibg = {
    highlight = 'BufferLineBufferInactive',
    attribute = 'bg',
  }
  local buffer_visible_guibg = {
    highlight = 'BufferLineBufferVisible',
    attribute = 'bg',
  }
  local buffer_selected_guifg = {
    highlight = 'BufferLineBufferInactive',
    attribute = 'fg',
  }
  local buffer_selected_guibg = {
    highlight = 'BufferLineBufferSelected',
    attribute = 'bg',
  }

  require('bufferline').setup {
    options = {
      number = 'none',
      show_buffer_icons = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      separator_style = 'slant',
      diagnostics = false,
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'File Explorer',
          highlight = 'PanelHeading',
          padding = 1,
        }, {
          filetype = 'DiffviewFiles',
          text = 'Diff View',
          highlight = 'PanelHeading',
          padding = 1,
        }, {filetype = 'flutterToolsOutline'},
      },
    },
    highlights = {
      fill = {guibg = fill_highlight},
      tab = {guibg = buffer_inactive_guibg},
      tab_selected = {gui = 'bold', guibg = buffer_selected_guibg},
      buffer_visible = {guibg = buffer_visible_guibg},
      buffer_selected = {
        gui = 'bold',
        guifg = buffer_selected_guifg,
        guibg = buffer_selected_guibg,
      },
      background = {guibg = buffer_inactive_guibg}, -- Inactive buffer background.
      duplicate = {guibg = buffer_inactive_guibg}, -- Disambiguation part (path) background.
      duplicate_visible = {guibg = buffer_visible_guibg},
      duplicate_selected = {
        guifg = buffer_selected_guifg,
        guibg = buffer_selected_guibg,
      },
      separator = {guifg = fill_highlight, guibg = buffer_inactive_guibg},
      separator_visible = {guifg = fill_highlight, guibg = buffer_visible_guibg},
      separator_selected = {
        guifg = fill_highlight,
        guibg = buffer_selected_guibg,
      },
    },
  }

  require('which-key').register({
    name = '+buffers',
    ['<space>'] = {
      function() vim.api.nvim_command('BufferLinePick') end, 'Select',
    },
    n = {function() vim.api.nvim_command('BufferLineCycleNext') end, 'Next'},
    p = {function() vim.api.nvim_command('BufferLineCyclePrev') end, 'Previous'},
    m = {
      name = '+move',
      n = {
        function() vim.api.nvim_command('BufferLineMoveNext') end, 'Move right',
      },
      p = {
        function() vim.api.nvim_command('BufferLineMovePrev') end, 'Move left',
      },
    },
    s = {
      name = '+sort',
      d = {
        function() vim.api.nvim_command('BufferLineSortByDirectory') end,
        'Sort by directories',
      },
      e = {
        function() vim.api.nvim_command('BufferLineSortByExtension') end,
        'Sort by extensions',
      },
    },
  }, {prefix = '<leader>b'})
end
