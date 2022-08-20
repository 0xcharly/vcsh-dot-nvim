require("nvim-tree").setup {
  renderer = {
    icons = {
      show = {
        folder = false,
      },
    },
  },
}

require("which-key").register({
  t = { require("nvim-tree").toggle, "File Explorer" },
}, { prefix = "<leader>" })
