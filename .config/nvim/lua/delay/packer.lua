local is_bootstrap_run = false

local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  is_bootstrap_run = true
  fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

return require("packer").startup {
  function(use)
    -- Use local checkout when available.
    local local_use = function(plugin_name, opts)
      opts = opts or {}

      local local_plugin_path = vim.fn.expand("~/Developer/" .. plugin_name)
      if vim.fn.isdirectory(local_plugin_path) == 1 then
        opts[1] = local_plugin_path
      else
        opts[1] = string.format("0xcharly/%s", plugin_name)
      end

      use(opts)
    end

    -- Switch to self-managed on the first run after manual checkout.
    use "wbthomason/packer.nvim"
    use "lewis6991/impatient.nvim"

    use "folke/which-key.nvim" --- Shortcuts/mappings.
    --- Language syntaxes.
    use "nvim-treesitter/nvim-treesitter"
    use "nvim-treesitter/nvim-treesitter-context"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use "numToStr/Comment.nvim"

    use "joelspadin/tree-sitter-devicetree"

    use "kyazdani42/nvim-web-devicons"
    use "yamatsum/nvim-web-nonicons" --- Fancy icons.
    use "nvim-lualine/lualine.nvim" --- Status bar.
    use { "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" }
    use "nvim-telescope/telescope-packer.nvim"
    use "nvim-telescope/telescope-fzf-writer.nvim"
    use "nvim-telescope/telescope-symbols.nvim"
    use "nvim-telescope/telescope-file-browser.nvim"
    use { "nvim-telescope/telescope-frecency.nvim", requires = "tami5/sqlite.lua" }
    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      cond = fn.executable "make" == 1,
    } --- Fuzzy finder.

    use "mrjones2014/smart-splits.nvim" -- Navigation.
    use "Pocco81/true-zen.nvim"
    use "kyazdani42/nvim-tree.lua"
    --- Remember cursor position when reopening files.
    use {
      "ethanholz/nvim-lastplace",
      config = function()
        require("nvim-lastplace").setup()
      end,
    }
    use "lukas-reineke/indent-blankline.nvim" --- Indentation.
    --- Git Gutter.
    use { "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" }

    -- Colorschemes.
    use "tjdevries/colorbuddy.nvim"
    local_use "primebuddy.nvim"

    use "akinsho/nvim-bufferline.lua" --- Buffer as tabs.
    use { "akinsho/toggleterm.nvim", tag = "v2.*" }
    use "ldelossa/buffertag"

    -- Language support.
    use "sbdchd/neoformat" --- Formatters.
    use "L3MON4D3/LuaSnip"
    use "neovim/nvim-lspconfig" -- Collection of configurations for build-in LSP client.
    use "williamboman/mason.nvim" -- Automaticall install language servers and tools to stdpath.
    use "williamboman/mason-lspconfig.nvim" -- Mason language servers.
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lsp-document-symbol"
    use "hrsh7th/cmp-path"
    use "mtoohey31/cmp-fish"
    use "tamago324/cmp-zsh"
    use "saadparwaiz1/cmp_luasnip"
    use "onsails/lspkind-nvim"
    use "crispgm/cmp-beancount"
    --- Smart increments.
    use "monaqa/dial.nvim"

    --- Text manipulation
    use "godlygeek/tabular" -- Quickly align text by pattern
    use "tpope/vim-repeat" -- Repeat actions better
    use "tpope/vim-surround" -- Surround text objects easily

    if is_bootstrap_run then
      require("packer").sync()
    end
  end,
  config = {
    max_jobs = 32,
    luarocks = { python_cmd = "python3" },
    display = {
      open_fn = function()
        return require("packer.util").float { border = "single" }
      end,
    },
  },
}
