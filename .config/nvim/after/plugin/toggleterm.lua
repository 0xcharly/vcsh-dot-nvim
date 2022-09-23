-- Terminal config.
if vim.loop.os_uname().sysname == 'Darwin' then
  vim.o.shell = "/opt/homebrew/bin/fish"
else
  vim.o.shell = "/usr/bin/fish"
end

require("toggleterm").setup { float_opts = { border = "rounded" } }

local mappings = require("delay.mappings")

mappings.nnoremap("<C-M-t>", ":ToggleTerm direction=float<CR>")
mappings.tnoremap("<C-M-t>", "<C-\\><C-N>:ToggleTerm direction=float<CR>")
mappings.tnoremap("<C-Esc>", "<C-\\><C-N><Esc>")

mappings.nnoremap('<leader>th', ":ToggleTerm direction=horizontal<CR>")
mappings.nnoremap('<leader>tv', ":ToggleTerm direction=vertical<CR>")
mappings.nnoremap('<leader>tt', ":ToggleTerm direction=tab<CR>")
mappings.nnoremap('<leader>t<space>', ":ToggleTerm direction=float<CR>")
