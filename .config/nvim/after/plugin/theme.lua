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

require("onedark").setup()

local hl = function(highlightGroup, opts)
    vim.api.nvim_set_hl(0, highlightGroup, opts)
end

-- Darker background for better contrast.
hl("Normal", { bg = "#21252b" })
hl("NormalNC", { bg = "#21252b" })
hl("NonText", { bg = "#21252b" })
hl("FoldColumn", { bg = "#21252b" })
hl("SignColumn", { bg = "#21252b" })

hl("WildMenu", { bg = "#282c34" })
hl("Pmenu", { bg = "#282c34" })

hl("Visual", { bg = "#31363f" })
hl("PmenuSel", { bg = "#31363f" })

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

require("lualine").setup {
    options = {
        icons_enabled = false,
        theme = "onedark",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = { "filename", "diagnostics" },
        lualine_x = { "fileformat", "encoding", "filetype", "progress", "location" },
        lualine_y = {},
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
}

-- vim.cmd [[colorscheme onedark]]
-- vim.cmd [[ hi Normal guibg=#1e222b ]]

-- vim.g.doom_one_terminal_colors = true
-- vim.cmd [[colorscheme catppuccin]]
-- vim.cmd [[colorscheme tokyonight-night]]
-- vim.cmd [[colorscheme onedark]]
-- require('onedark').setup {
--     style = 'darker'
-- }
-- require('onedark').load()
