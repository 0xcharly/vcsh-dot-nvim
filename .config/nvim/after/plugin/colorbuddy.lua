vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

require("catppuccin").setup {
  integrations = {
    gitgutter = true,
    gitsigns = true,
    which_key = true,
  },
}

vim.cmd [[colorscheme catppuccin]]

-- require("colorbuddy").colorscheme "primebuddy"
--
-- -- nvim-cmp highlight groups.
-- local _, c, Group, g, s = require("colorbuddy").setup()
--
-- -- Cmp
-- Group.new("CmpItemAbbr", g.Normal)
-- Group.new("CmpItemKind", g.Special)
-- Group.new("CmpItemMenu", g.Comment)
--
-- Group.link("CmpDocumentation", g.NormalFloat)
-- Group.link("CmpDocumentationBorder", g.FloatBorder)
-- Group.new("CmpItemAbbrDeprecated", c.syntaxDeprecated, nil, s.strikethrough)
-- Group.new("CmpItemAbbrMatch", c.roleAccent)
-- Group.new("CmpItemAbbrMatchFuzzy", c.roleAccent, nil, s.italic)
-- Group.new("CmpItemKindVariable", c.syntaxEntityTag)
-- Group.new("CmpItemKindInterface", c.syntaxEntityTag)
-- Group.new("CmpItemKindText", c.syntaxEntityTag)
-- Group.new("CmpItemKindFunction", c.syntaxFunction)
-- Group.new("CmpItemKindMethod", c.syntaxFunction)
-- Group.new("CmpItemKindKeyword", c.syntaxKeyword)
-- Group.new("CmpItemKindProperty", c.syntaxKeyword)
-- Group.new("CmpItemKindUnit", c.syntaxKeyword)
