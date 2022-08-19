-- Terminal config.
vim.o.shell = "/opt/homebrew/bin/fish"

require("toggleterm").setup { float_opts = { border = "rounded" } }

vim.keymap.set("n", "<C-M-t>", ":ToggleTerm direction=float<CR>")
vim.keymap.set("t", "<C-M-t>", "<C-\\><C-N>:ToggleTerm direction=float<CR>")
vim.keymap.set("t", "<C-Esc>", "<C-\\><C-N><Esc>")

require("which-key").register({
  t = {
    name = "+terminal",
    h = { ":ToggleTerm direction=horizontal<CR>", "[H]orizontal" },
    v = { ":ToggleTerm direction=vertical<CR>", "[V]ertical" },
    t = { ":ToggleTerm direction=tab<CR>", "[T]ab" },
    f = { ":ToggleTerm direction=float<CR>", "[F]loat" },
    ["<space>"] = { ":ToggleTerm<CR>", "[T]oggle" },
  },
}, { prefix = "<leader>" })
