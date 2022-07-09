local palette = require "primebuddy.palette"
local scale = palette.scale
local theme = palette.theme

local tint_lualine_group = function(color)
  return {
    a = { fg = theme.canvas.default, bg = color, gui = "bold" },
    b = { fg = theme.fg.onEmphasis, bg = theme.neutral.muted },
    c = { fg = theme.fg.default, bg = theme.canvas.overlay },
  }
end

require("lualine").setup {
  options = {
    icons_enabled = false,
    theme = {
      normal = tint_lualine_group(scale.blue.shade3),
      insert = tint_lualine_group(scale.green.shade3),
      command = tint_lualine_group(scale.purple.shade3),
      visual = tint_lualine_group(scale.yellow.shade3),
      replace = tint_lualine_group(scale.red.shade3),
      inactive = tint_lualine_group(scale.gray.shade3),
    },
  },
  sections = {
    lualine_b = {
      "branch",
      {
        "diff",
        diff_color = {
          added = { fg = theme.diffstat.addition.fg },
          modified = { fg = theme.diffstat.modification.fg },
          removed = { fg = theme.diffstat.deletion.fg },
        },
      },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
          error = " ",
          warn = " ",
          info = " ",
          hint = " ",
        },
        diagnostics_color = {
          error = { fg = theme.danger.onOverlay },
          warn = { fg = theme.attention.onOverlay },
          info = { fg = theme.accent.onOverlay },
          hint = { fg = theme.neutral.onOverlay },
        },
      },
    },
  },
}
