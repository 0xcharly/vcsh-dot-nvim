-- Set the proper file type on ZMK files.
local zmk_home = vim.fn.expand "~/Developer/zmk-config/"
local adjust_filetype_group = vim.api.nvim_create_augroup("AdjustFiletype", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { zmk_home .. "*.keymap", zmk_home .. "*.conf", zmk_home .. "*.dtsi", zmk_home .. "*.overlay" },
  group = adjust_filetype_group,
  command = "set ft=devicetree",
})
