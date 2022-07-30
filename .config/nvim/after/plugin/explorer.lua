require("nvim-tree").setup()

require("which-key").register({
  t = { require("nvim-tree").toggle, "File Explorer" },
}, { prefix = "<leader>" })
