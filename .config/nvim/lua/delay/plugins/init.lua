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
      requires = {
        'nvim-treesitter/nvim-treesitter-context', 'folke/which-key.nvim',
        'joelspadin/tree-sitter-devicetree',
      },
    }
    --- Fancy icons.
    use 'kyazdani42/nvim-web-devicons'
    use 'yamatsum/nvim-web-nonicons'
    --- Fuzzy finder.
    use {
      'nvim-telescope/telescope.nvim',
      config = conf 'telescope',
      requires = {
        'nvim-lua/plenary.nvim', 'folke/which-key.nvim', 'nvim-lua/popup.nvim',
        'nvim-telescope/telescope-packer.nvim',
        'nvim-telescope/telescope-fzf-writer.nvim',
        'nvim-telescope/telescope-symbols.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
        {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}, {
          'nvim-telescope/telescope-frecency.nvim',
          requires = 'tami5/sql.nvim',
          after = 'telescope.nvim',
        },
      },
    }

    -- Navigation.
    use {'mrjones2014/smart-splits.nvim', config = conf 'smartsplits'}
    --- Remember cursor position when reopening files.
    use {
      'ethanholz/nvim-lastplace',
      config = function() require('nvim-lastplace').setup() end,
    }

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

    -- Colorschemes.
    use {'tjdevries/colorbuddy.nvim', config = conf 'colorbuddy.github'}

    -- Language support.
    --- Formatters.
    use {'sbdchd/neoformat', config = conf 'neoformat'}
    --- LSP & Completion.
    use {'williamboman/nvim-lsp-installer'}
    use {
      'neovim/nvim-lspconfig',
      config = conf 'lspconfig',
      requires = 'williamboman/nvim-lsp-installer',
    }
    use {
      'hrsh7th/nvim-cmp',
      config = conf 'cmp',
      requires = {
        'hrsh7th/cmp-buffer', 'hrsh7th/cmp-cmdline', 'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-nvim-lsp-document-symbol',
        'hrsh7th/cmp-path', 'neovim/nvim-lspconfig', 'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
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
