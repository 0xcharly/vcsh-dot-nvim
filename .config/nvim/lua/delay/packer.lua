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

            local local_plugin_path = vim.fn.expand("~/dev/" .. plugin_name)
            if vim.fn.isdirectory(local_plugin_path) == 1 then
                opts[1] = local_plugin_path
            else
                opts[1] = string.format("0xcharly/%s", plugin_name)
            end

            use(opts)
        end

        -- Local checkout of optional company plugins.
        local company_use = function(plugin_name, opts)
            opts = opts or {}

            local local_plugin_path = vim.fn.expand("~/dev/" .. plugin_name)
            if vim.fn.isdirectory(local_plugin_path) == 1 then
                opts[1] = local_plugin_path
                use(local_plugin_path)
            end
        end

        -- Switch to self-managed on the first run after manual checkout.
        use "wbthomason/packer.nvim"

        --- Language syntaxes.
        use "nvim-treesitter/nvim-treesitter"
        use "nvim-treesitter/nvim-treesitter-context"
        use "nvim-treesitter/nvim-treesitter-textobjects"
        use "nvim-treesitter/playground"
        use "JoosepAlviste/nvim-ts-context-commentstring"

        use "joelspadin/tree-sitter-devicetree"

        -- Language support.
        use "crispgm/cmp-beancount"
        use "fladson/vim-kitty"

        -- LSP.
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
        use "j-hui/fidget.nvim"

        -- Formatters.
        use "sbdchd/neoformat"

        -- Dressing.
        use { "yamatsum/nvim-web-nonicons", requires = "kyazdani42/nvim-web-devicons" }
        use "akinsho/nvim-bufferline.lua" -- Tabs. (yes, tabs.)
        use "nvim-lualine/lualine.nvim" --- Status bar.
        use "stevearc/dressing.nvim"
        use "rcarriga/nvim-notify"
        use "numToStr/Comment.nvim"
        use "ethanholz/nvim-lastplace"

        -- Colorschemes.
        use { "catppuccin/nvim", as = "catppuccin" }

        -- Term.
        use { "akinsho/toggleterm.nvim", tag = "v2.*" }

        -- Telescope.
        use { "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" }
        use "nvim-telescope/telescope-symbols.nvim"
        use "nvim-telescope/telescope-file-browser.nvim"
        use { "nvim-telescope/telescope-frecency.nvim", requires = "tami5/sqlite.lua" }
        use {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        }
        company_use "telescope-codesearch.nvim"

        -- FZF.
        use { "junegunn/fzf", dir = "~/.fzf", run = "./install --all" }
        use { "junegunn/fzf.vim" }

        --- Git integration.
        use { "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" }
        use { "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" }
        use { "ThePrimeagen/git-worktree.nvim" }

        -- Github integration.
        if vim.fn.executable "gh" == 1 then
            use "pwntester/octo.nvim"
        end

        --- Motions and convenience plugins.
        use "godlygeek/tabular" -- Quickly align text by pattern
        use "tpope/vim-repeat" -- Repeat actions better
        use "tpope/vim-surround" -- Surround text objects easily
        use "tpope/vim-scriptease" -- Convenience functions.
        use "monaqa/dial.nvim"
        use "mrjones2014/smart-splits.nvim" -- Navigation.
        use { "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons" } }
        use { "ThePrimeagen/harpoon", requires = "nvim-lua/plenary.nvim" }
        use "mbbill/undotree"

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
