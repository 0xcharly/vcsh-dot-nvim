require("nvim-lastplace").setup {}

require("nvim-web-devicons").setup {
    override = {
        [".gitmodules"] = {
            icon = "",
            color = "#41535b",
            cterm_color = "59",
            name = "GitModules",
        },
    },
}

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

require("catppuccin").setup {
    native_lsp = {
        enabled = true,
        virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
        },
        underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
        },
    },
    integrations = {
        cmp = true,
        gitgutter = true,
        gitsigns = true,
        neogit = true,
        notify = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
    },
}

vim.cmd [[colorscheme catppuccin]]
