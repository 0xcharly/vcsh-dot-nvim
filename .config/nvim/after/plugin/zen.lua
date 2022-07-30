require("true-zen").setup()

require("which-key").register({
  z = {
    name = "+zen",
    n = { ":TZNarrow<cr>", "[Z]en [N]arrow" },
    v = { ":'<,'>TZNarrow<cr>", "[Z]en [N]arrow" },
    f = { ":TZFocus<cr>", "[Z]en [F]ocus" },
    m = { ":TZMinimalist<cr>", "[Z]en [M]inimalist" },
    a = { ":TZAtaraxis<cr>", "[Z]en [A]taraxis" },
  },
}, { prefix = "<leader>" })

vim.api.nvim_set_keymap("v", "<leader>zv", ":'<,'>TZNarrow<CR>", {})
