local mappings = require('delay.mappings')

-- To use `ALT+{h,j,k,l}` to navigate windows from any mode:
mappings.tnoremap("<M-Left>", "<C-\\><C-N><C-w>h")
mappings.tnoremap("<M-Down>", "<C-\\><C-N><C-w>j")
mappings.tnoremap("<M-Up>", "<C-\\><C-N><C-w>k")
mappings.tnoremap("<M-Right>", "<C-\\><C-N><C-w>l")
mappings.inoremap("<M-Left>", "<C-\\><C-N><C-w>h")
mappings.inoremap("<M-Down>", "<C-\\><C-N><C-w>j")
mappings.inoremap("<M-Up>", "<C-\\><C-N><C-w>k")
mappings.inoremap("<M-Right>", "<C-\\><C-N><C-w>l")
mappings.nnoremap("<M-Left>", "<C-w>h")
mappings.nnoremap("<M-Down>", "<C-w>j")
mappings.nnoremap("<M-Up>", "<C-w>k")
mappings.nnoremap("<M-Right>", "<C-w>l")
mappings.nnoremap("<M-S-Left>", ":tabprev<CR>")
mappings.nnoremap("<M-S-Right>", ":tabnext<CR>")
mappings.tnoremap("<M-S-Left>", "<C-\\><C-N>:tabprev<CR>")
mappings.tnoremap("<M-S-Right>", "<C-\\><C-N>:tabnext<CR>")

mappings.nnoremap("<leader>ws", ":split<CR>")
mappings.nnoremap("<leader>wv", ":vsplit<CR>")
mappings.nnoremap("<leader>w=", "<C-W>=")

-- Packer.
mappings.nnoremap("<leader>xC", ":PackerClean<CR>")
mappings.nnoremap("<leader>xc", ":PackerCompile<CR>")
mappings.nnoremap("<leader>xi", ":PackerInstall<CR>")
mappings.nnoremap("<leader>xx", ":PackerSync<CR>")

-- Better virtual paste.
mappings.xnoremap("<leader>p", '"_dP')

-- Better yank.
mappings.nnoremap("<leader>y", '"+y')
mappings.vnoremap("<leader>y", '"+y')
mappings.nmap("<leader>Y", '"+Y')

-- Format.
mappings.nnoremap("<leader>f", ":Neoformat<CR>")
mappings.nnoremap("<leader>F", ":Neoformat<CR>")

-- Harpoon.
mappings.nnoremap("<leader>mm", function() require('harpoon.ui').toggle_quick_menu() end)
mappings.nnoremap("<leader>ma", function() require('harpoon.mark').add_file() end)
mappings.nnoremap("<leader>mh", function() require('harpoon.ui').nav_file(1) end)
mappings.nnoremap("<leader>mt", function() require('harpoon.ui').nav_file(2) end)
mappings.nnoremap("<leader>mn", function() require('harpoon.ui').nav_file(3) end)
mappings.nnoremap("<leader>ms", function() require('harpoon.ui').nav_file(4) end)
