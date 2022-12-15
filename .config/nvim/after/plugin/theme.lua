require("nvim-lastplace").setup {}
require("nvim-web-devicons").setup {}

-- Catppuccin.
require("catppuccin").setup {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
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
    custom_highlights = function(colors)
        return {
            ["@hint.inlay"] = { fg = colors.surface2, style = {} },
        }
    end,
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

vim.cmd [[ colorscheme catppuccin ]]
