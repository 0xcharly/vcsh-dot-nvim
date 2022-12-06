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
        local use_if_exists = function(plugin_name, opts)
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
        use {
            "nvim-neorg/neorg",
            ft = "norg",
            after = "nvim-treesitter",
            config = function()
                require("neorg").setup {
                    load = {
                        ["core.defaults"] = {},
                        ["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
                        ["core.norg.concealer"] = {},
                    },
                }
            end,
        }

        use {
            "VonHeikemen/lsp-zero.nvim",
            requires = {
                -- LSP Support
                { "neovim/nvim-lspconfig" },
                { "williamboman/mason.nvim" },
                { "williamboman/mason-lspconfig.nvim" },

                -- Autocompletion
                { "hrsh7th/nvim-cmp" },
                { "hrsh7th/cmp-buffer" },
                { "hrsh7th/cmp-path" },
                { "saadparwaiz1/cmp_luasnip" },
                { "hrsh7th/cmp-nvim-lsp" },
                { "hrsh7th/cmp-nvim-lua" },

                -- Snippets
                { "L3MON4D3/LuaSnip" },
                { "rafamadriz/friendly-snippets" },
            },
        }

        -- LSP.
        -- use "L3MON4D3/LuaSnip"
        -- use "neovim/nvim-lspconfig" -- Collection of configurations for build-in LSP client.
        -- use "williamboman/mason.nvim" -- Automaticall install language servers and tools to stdpath.
        -- use "williamboman/mason-lspconfig.nvim" -- Mason language servers.
        -- use "hrsh7th/nvim-cmp"
        -- use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-cmdline"
        -- use "hrsh7th/cmp-nvim-lua"
        -- use "hrsh7th/cmp-nvim-lsp"
        use "hrsh7th/cmp-nvim-lsp-document-symbol"
        use "hrsh7th/cmp-path"
        use "mtoohey31/cmp-fish"
        use "tamago324/cmp-zsh"
        use "saadparwaiz1/cmp_luasnip"
        use "onsails/lspkind-nvim"
        use "j-hui/fidget.nvim"

        -- UI.
        use { "yamatsum/nvim-web-nonicons", requires = "kyazdani42/nvim-web-devicons" }
        use {
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
        }
        use "feline-nvim/feline.nvim"

        -- Colorschemes.
        use { "catppuccin/nvim", as = "catppuccin" }
        use { "folke/tokyonight.nvim", as = "tokyonight" }
        -- use "joshdick/onedark.vim"
        use "navarasu/onedark.nvim"
        -- use "monsonjeremy/onedark.nvim"
        use "olimorris/onedarkpro.nvim"
        use "NTBBloodbath/doom-one.nvim"
        use "Shatur/neovim-ayu"
        use "pacokwon/onedarkhc.vim"

        -- Telescope.
        use { "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" }
        use "nvim-telescope/telescope-symbols.nvim"
        use "nvim-telescope/telescope-file-browser.nvim"
        use {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        }
        use_if_exists "telescope-codesearch.nvim"

        -- External tools integration.
        use { "junegunn/fzf" }
        use { "junegunn/fzf.vim" }
        use "ThePrimeagen/git-worktree.nvim"
        use { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }

        -- Github integration.
        if vim.fn.executable "gh" == 1 then
            use "pwntester/octo.nvim"
        end

        -- Formatters.
        use "sbdchd/neoformat"

        --- Motions and convenience plugins.
        use "tpope/vim-repeat" -- Repeat actions better
        use "tpope/vim-surround" -- Surround text objects easily
        use "tpope/vim-scriptease" -- Convenience functions.
        use "monaqa/dial.nvim"
        use { "ThePrimeagen/harpoon", requires = "nvim-lua/plenary.nvim" }
        use "mbbill/undotree"
        use "numToStr/Comment.nvim"
        use "ethanholz/nvim-lastplace"
        use { "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" }
        use "folke/zen-mode.nvim"

        if is_bootstrap_run then
            require("packer").sync()
        end
    end,
    config = {
        luarocks = { python_cmd = "python3" },
        display = {
            open_fn = function()
                return require("packer.util").float { border = "single" }
            end,
        },
    },
}
