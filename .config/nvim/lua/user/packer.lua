local is_bootstrap_run = false
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap_run = true
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    vim.cmd.packadd("packer.nvim")
end

return require("packer").startup({
    function(use)
        -- Use local checkout when available, or fall back to personal fork otherwise.
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
        use("wbthomason/packer.nvim")
        use("lewis6991/impatient.nvim")

        --- Language syntaxes.
        use("nvim-treesitter/nvim-treesitter")
        use("nvim-treesitter/nvim-treesitter-context")
        use("nvim-treesitter/nvim-treesitter-textobjects")
        use({ "nvim-treesitter/playground", fn = "LoadTSPlayground" })

        -- 3rd-party Treesitter language support.
        use({ "joelspadin/tree-sitter-devicetree", ft = "devicetree" })

        -- Language support.
        use({ "crispgm/cmp-beancount", ft = "beancount" })
        use({ "fladson/vim-kitty", ft = "kitty" })
        use({
            "nvim-neorg/neorg",
            tag = "0.0.18", -- Until GTD makes it back in the main branch.
            ft = "norg",
            after = "nvim-treesitter",
            config = function()
                require("neorg").setup({
                    load = {
                        ["core.defaults"] = {},
                        ["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
                        ["core.norg.concealer"] = {},
                    },
                })
            end,
        })

        -- LSP Support.
        use("neovim/nvim-lspconfig")
        use("williamboman/mason.nvim")
        use("williamboman/mason-lspconfig.nvim")

        -- Autocompletion.
        use("hrsh7th/nvim-cmp")
        use("hrsh7th/cmp-buffer")
        use("hrsh7th/cmp-path")
        use("hrsh7th/cmp-cmdline")
        use("hrsh7th/cmp-nvim-lsp-document-symbol")
        use("hrsh7th/cmp-nvim-lsp")
        use("hrsh7th/cmp-nvim-lua")

        use("onsails/lspkind.nvim")

        -- 3rd-party languages completion support.
        use({ "mtoohey31/cmp-fish", ft = "fish" })
        use({ "tamago324/cmp-zsh", ft = "zsh" })

        -- Tools.
        use({ "mfussenegger/nvim-dap", ft = "rust" })
        use({ "simrat39/rust-tools.nvim", ft = "rust" })

        -- UI.
        use({ "yamatsum/nvim-web-nonicons", requires = { "nvim-tree/nvim-web-devicons" } })

        -- Colorschemes.
        use({ "catppuccin/nvim", as = "catppuccin" })
        use({ "folke/noice.nvim", requires = "MunifTanjim/nui.nvim" })

        -- Telescope.
        use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
        use("nvim-telescope/telescope-symbols.nvim")
        use({
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
            cond = vim.fn.executable("make") == 1,
        })

        -- 3rd-party telescope plugins.
        use("debugloop/telescope-undo.nvim")
        use_if_exists("telescope-codesearch.nvim")

        -- External tools integration.
        use({ "ibhagwan/fzf-lua", requires = { "nvim-tree/nvim-web-devicons" } })
        use({ "sindrets/diffview.nvim", requires = { "nvim-lua/plenary.nvim" } })

        -- Formatters.
        use("sbdchd/neoformat")

        --- Motions and convenience plugins.
        use("tpope/vim-repeat") -- Repeat actions better
        use("tpope/vim-surround") -- Surround text objects easily
        use({ "ThePrimeagen/harpoon", requires = { "nvim-lua/plenary.nvim" } })
        use("mbbill/undotree")
        use("numToStr/Comment.nvim")
        use("ethanholz/nvim-lastplace")

        if is_bootstrap_run then require("packer").sync() end
    end,
    config = {
        display = {
            open_fn = function() return require("packer.util").float({ border = "single" }) end,
        },
    },
})
