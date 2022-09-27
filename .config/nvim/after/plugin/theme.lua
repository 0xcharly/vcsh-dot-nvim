require("buffertag").setup { border = "rounded" }
require("nvim-lastplace").setup {}

require("nvim-tree").setup {
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    icons = {
      show = {
        folder = true,
      },
      glyphs = {
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
      },
    },
  },
}

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

require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "catppuccin",
  },
  sections = {
    lualine_b = { "filename" },
    lualine_c = {
      "branch",
      "diff",
      {
        "diagnostics",

        -- Table of diagnostic sources, available sources are:
        --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
        -- or a function that returns a table as such:
        --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
        sources = { "nvim_lsp", "nvim_diagnostic", "nvim_workspace_diagnostic" },

        -- Displays diagnostics for the defined severity types
        sections = { "error", "warn", "info", "hint" },

        diagnostics_color = {
          -- Same values as the general color option can be used here.
          error = "DiagnosticError", -- Changes diagnostics' error color.
          warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
          info = "DiagnosticInfo", -- Changes diagnostics' info color.
          hint = "DiagnosticHint", -- Changes diagnostics' hint color.
        },
        symbols = {
          error = " ",
          warn = " ",
          hint = " ",
          info = " ",
        },
        colored = true, -- Displays diagnostics status in color if set to true.
        update_in_insert = false, -- Update diagnostics in insert mode.
        always_visible = false, -- Show diagnostics even if there are none.
      },
    },
  },
}

require("bufferline").setup {
  highlights = require("catppuccin.groups.integrations.bufferline").get {
    styles = { "italic", "bold" },
  },
  options = {
    number = "none",
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = "slant",
    diagnostics = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "DiffviewFiles",
        text = "Diff View",
        highlight = "PanelHeading",
        padding = 1,
      },
      { filetype = "flutterToolsOutline" },
    },
  },
}
