require("nvim-lastplace").setup {}

require("nvim-web-devicons").setup {}

--[[
local c = require("onedark.palette").darker
require("onedark").setup {
    style = "darker",
    highlights = {
        ["@field"] = { fg = "$fg" },
        ["@variable"] = { fg = "$red" },
        ["@function.builtin"] = { fg = "$orange" },
        DiagnosticHint = { fg = "$grey" },
        DiagnosticVirtualTextHint = {
            bg = require("onedark.util").darken(c.grey, 0.1, c.bg0),
            fg = "$grey",
        },
        Search = {
            bg = require("onedark.util").darken(c.blue, 0.7, c.bg0),
            fg = c.black,
        },
        IncSearch = {
            bg = require("onedark.util").darken(c.blue, 0.7, c.bg0),
            fg = c.black,
        },
    },
    diagnostics = {
        undercurl = false,
    }
}
require("onedark").load()
--]]

-- Catppuccin.
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

vim.cmd [[ colorscheme catppuccin ]]
