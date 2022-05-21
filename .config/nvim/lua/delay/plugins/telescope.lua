return function()
  local telescope = require 'telescope'
  local actions = require 'telescope.actions'
  local builtins = require 'telescope.builtin'
  local themes = require 'telescope.themes'
  local action_state = require 'telescope.actions.state'

  telescope.setup {
    defaults = {
      prompt_prefix = '  ',
      entry_prefix = '   ',
      selection_caret = ' ❯ ',
      file_ignore_patterns = {'%.jpg', '%.jpeg', '%.png', '%.otf', '%.ttf'},
      layout_strategy = 'flex',
      -- winblend = 7,
    },
    extensions = {
      frecency = {
        workspaces = {
          ['conf'] = vim.env.DOTFILES,
          ['project'] = vim.env.PROJECTS_DIR,
          ['wiki'] = vim.g.wiki_path,
        },
      },
      fzf = {
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
      },
    },
  }

  telescope.load_extension('fzf')

  local function buffers()
    builtins.buffers {
      sort_lastused = true,
      show_all_buffers = true,
      attach_mappings = function(prompt_bufnr, map)
        local delete_buf = function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          vim.api.nvim_buf_delete(selection.bufnr, {force = true})
        end
        map('i', '<c-x>', delete_buf)
        return true
      end,
    }
  end

  local function frecency()
    telescope.extensions.frecency.frecency(
        themes.get_dropdown {
          -- winblend = 10,
          border = true,
          previewer = false,
          shorten_path = false,
        })
  end

  -- General finds files function which changes the picker depending on the
  -- current buffers path.
  local function files()
    if vim.fn.isdirectory('.git') > 0 then
      -- If in a git project, use :Telescope git_files
      builtins.git_files()
    else
      -- Otherwise, use :Telescope find_files
      builtins.find_files()
    end
  end

  local function reloader() builtins.reloader(themes.get_dropdown()) end

  local function workspace_symbols() builtins.lsp_dynamic_workspace_symbols {} end

  local whichKey = require 'which-key'
  whichKey.register({
    f = {
      name = '+telescope',
      a = {function() vim.api.nvim_command('Telescope') end, 'Builtins'},
      b = {buffers, 'Buffers'},
      c = {builtins.git_commits, 'Commits'},
      f = {builtins.find_files, 'Files'},
      g = {builtins.live_grep, 'Grep'},
      h = {frecency, 'History'},
      m = {builtins.man_pages, 'Man pages'},
      r = {reloader, 'Module reloader'},
      t = {
        function()
          vim.api.nvim_command('tabnew')
          files()
        end, 'Open Telescope in a new tab',
      },
      w = {workspace_symbols, 'Workspace symbols', silent = false},
      ['<space>'] = {files, 'Smart files'},
      ['?'] = {builtins.help_tags, 'Help'},
    },
  }, {prefix = '<leader>'})
end
