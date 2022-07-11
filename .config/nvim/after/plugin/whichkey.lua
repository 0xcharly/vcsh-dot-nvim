local wk = require "which-key"

wk.setup {
  key_labels = {
    ["<cr>"] = "RET",
    ["<space>"] = "SPC",
    ["<tab>"] = "TAB",
  },
  triggers = "auto",
  plugins = {
    marks = false, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
}

local leader = {
  w = {
    name = "+windows",
    ["w"] = { "<C-W>p", "other-window" },
    ["d"] = { "<C-W>c", "delete-window" },
    ["-"] = { "<C-W>s", "split-window-below" },
    ["|"] = { "<C-W>v", "split-window-right" },
    ["2"] = { "<C-W>v", "layout-double-columns" },
    ["H"] = { "<C-W>5<", "expand-window-left" },
    ["T"] = { "<cmd>resize +5<cr>", "expand-window-below" },
    ["N"] = { "<C-W>5>", "expand-window-right" },
    ["C"] = { "<cmd>resize -5<cr>", "expand-window-up" },
    ["="] = { "<C-W>=", "balance-window" },
    ["s"] = { "<C-W>s", "split-window-below" },
    ["v"] = { "<C-W>v", "split-window-right" },
  },
  p = {
    name = "+packer",
    c = { "<cmd>PackerClean<cr>", "Clean" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    r = { "<cmd>PackerCompile<cr>", "Compile" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
  },
  s = "Grep word under the cursor",
  ["<space>"] = {
    name = "workspace",
    c = { "<cmd>tabnew<cr>", "New" },
    d = { "<cmd>tabclose<cr>", "Close" },
  },
}

for i = 0, 10 do
  leader[tostring(i)] = "which_key_ignore"
end

wk.register(leader, { prefix = "<leader>" })
