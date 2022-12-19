local mappings = require("delay.mappings")

-- To use `ALT+{h,j,k,l}` to navigate windows from any mode:
mappings.tnoremap("<M-Left>", "<C-\\><C-N><C-w>h")
mappings.tnoremap("<M-Down>", "<C-\\><C-N><C-w>j")
mappings.tnoremap("<M-Up>", "<C-\\><C-N><C-w>k")
mappings.tnoremap("<M-Right>", "<C-\\><C-N><C-w>l")

-- Make esc leave terminal mode
mappings.tnoremap("<leader><Esc>", "<C-\\><C-n>")
mappings.tnoremap("<Esc><Esc>", "<C-\\><C-n>")

-- Try and make sure to not mangle space items
mappings.tnoremap("<S-Space>", "<Space>")
mappings.tnoremap("<C-Space>", "<Space>")

mappings.inoremap("<M-Left>", "<C-\\><C-N><C-w>h")
mappings.inoremap("<M-Down>", "<C-\\><C-N><C-w>j")
mappings.inoremap("<M-Up>", "<C-\\><C-N><C-w>k")
mappings.inoremap("<M-Right>", "<C-\\><C-N><C-w>l")
mappings.nnoremap("<M-Left>", "<C-w>h")
mappings.nnoremap("<M-Down>", "<C-w>j")
mappings.nnoremap("<M-Up>", "<C-w>k")
mappings.nnoremap("<M-Right>", "<C-w>l")

mappings.nnoremap("<leader>pv", vim.cmd.Ex)
mappings.nnoremap("<LocalLeader>u", ":UndotreeShow<cr>")

mappings.vnoremap("J", ":m '>+1<cr>gv=gv")
mappings.vnoremap("K", ":m '<-2<cr>gv=gv")

mappings.nnoremap("Y", "yg$")
mappings.nnoremap("n", "nzzzv")
mappings.nnoremap("N", "Nzzzv")
mappings.nnoremap("J", "mzJ`z")
mappings.nnoremap("<C-d>", "<C-d>zz")
mappings.nnoremap("<C-u>", "<C-u>zz")

-- Better virtual paste.
mappings.xnoremap("<leader>p", '"_dP')
mappings.inoremap("<C-v>", '<C-o>"+p')
mappings.cnoremap("<C-v>", "<C-r>+")

-- Better yank.
mappings.nnoremap("<leader>y", '"+y')
mappings.vnoremap("<leader>y", '"+y')
mappings.nmap("<leader>Y", '"+Y')

-- Better delete.
mappings.nnoremap("<leader>d", '"_d')
mappings.vnoremap("<leader>d", '"_d')

-- Better jumps.
mappings.nnoremap("<C-k>", "<cmd>cnext<cr>zz")
mappings.nnoremap("<C-j>", "<cmd>cprev<cr>zz")
mappings.nnoremap("<leader>k", "<cmd>lnext<cr>zz")
mappings.nnoremap("<leader>j", "<cmd>lprev<cr>zz")

-- Format.
mappings.nnoremap("<LocalLeader>bf", ":Neoformat<cr>")

-- Tools integration.
mappings.nnoremap("<c-f>", "<cmd>!tmux new-window ~/.local/bin/open-tmux-workspace<cr>", { silent = true })
