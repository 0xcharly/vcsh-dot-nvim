require("nvim-tree").setup {
  renderer = {
    icons = {
      show = {
        folder = false,
      },
    },
  },
}

require("delay.mappings").nnoremap("<leader>e", require("nvim-tree").toggle)
