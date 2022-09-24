require("buffertag").setup { border = "rounded" }
require("nvim-lastplace").setup {}

require("nvim-tree").setup {
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

require("delay.mappings").nnoremap("<leader>e", require("nvim-tree").toggle)

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
