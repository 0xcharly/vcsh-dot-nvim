---Require a plugin config
---@param name string
---@return function
local function conf(name) return
    require(string.format('delay.plugins.%s', name)) end

return require('packer').startup({
  function()
    -- Switch to self-managed on the first run after manual checkout.
    use 'wbthomason/packer.nvim'

    -- Building blocks.
    --- Shortcuts/mappings.
    use {'folke/which-key.nvim', config = conf 'whichkey'}
    --- Language syntaxes.
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = conf 'treesitter',
      requires = 'folke/which-key.nvim',
    }
    --- Fancy icons.
    use 'kyazdani42/nvim-web-devicons'
    --- Fuzzy finder.
    use {
      'nvim-telescope/telescope.nvim',
      config = conf 'telescope',
      requires = {
        'nvim-lua/plenary.nvim', 'folke/which-key.nvim', 'nvim-lua/popup.nvim',
        'nvim-telescope/telescope-fzf-writer.nvim',
        'nvim-telescope/telescope-symbols.nvim',
        {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}, {
          'nvim-telescope/telescope-frecency.nvim',
          requires = 'tami5/sql.nvim',
          after = 'telescope.nvim',
        },
      },
    }

    -- Navigation.
    --- Tmux integration.
    use {
      'nathom/tmux.nvim',
      config = conf 'tmux',
      requires = 'folke/which-key.nvim',
    }
    --- File tree.
    use({
      'kyazdani42/nvim-tree.lua',
      cmd = {'NvimTreeToggle', 'NvimTreeClose'},
      config = conf 'tree',
    })
    --- Remember cursor position when reopening files.
    use {
      'ethanholz/nvim-lastplace',
      config = function() require('nvim-lastplace').setup() end,
    }
    --- Undo tree visualization.
    use {'mbbill/undotree', cmd = 'UndotreeToggle'}

    -- Window decorations.
    --- Indentation.
    use {'lukas-reineke/indent-blankline.nvim', config = conf 'indentline'}
    --- Buffer as tabs.
    use {
      'akinsho/nvim-bufferline.lua',
      config = conf 'bufferline',
      requires = 'folke/which-key.nvim',
      after = 'colorbuddy.nvim',
    }
    --- Status bar.
    use {
      'nvim-lualine/lualine.nvim',
      config = conf 'lualine',
      requires = 'kyazdani42/nvim-web-devicons',
    }
    --- Git Gutter.
    use {
      'lewis6991/gitsigns.nvim',
      event = 'BufReadPre',
      config = conf 'gitsigns',
      requires = 'nvim-lua/plenary.nvim',
    }
    -- RGB hex codes.
    use {
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup({'*', '!beancount'}, {mode = 'background'})
      end,
      event = 'BufReadPre',
    }

    -- Colorschemes.
    use {'tjdevries/colorbuddy.nvim', config = conf 'colorbuddy.dracula'}

    -- Language support.
    --- Formatters.
    use {'sbdchd/neoformat', config = conf 'neoformat'}
    --- LSP.
    use {'neovim/nvim-lspconfig', config = conf 'lspconfig'}
    --- Completion.
    use {
      'hrsh7th/nvim-cmp',
      config = conf 'cmp',
      requires = {
        'hrsh7th/cmp-buffer', 'hrsh7th/cmp-cmdline', 'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path', 'neovim/nvim-lspconfig',
        'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip',
      },
      after = {'nvim-lspconfig'},
    }
    --- Smart increments.
    use {'monaqa/dial.nvim', config = conf 'dial'}
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float {border = 'single'}
      end,
    },
  },
})
