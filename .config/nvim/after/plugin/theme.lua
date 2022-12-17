require("nvim-lastplace").setup {}
require("nvim-web-devicons").setup {}

-- Catppuccin.
require("catppuccin").setup {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    custom_highlights = function(colors)
        return {
            ["@hint.inlay"] = { fg = colors.surface1, style = { "italic" } },
        }
    end,
    integrations = {
        cmp = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
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
    },
}

vim.cmd.colorscheme "catppuccin"
