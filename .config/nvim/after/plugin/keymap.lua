local mappings = require "delay.mappings"

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

mappings.nnoremap("<leader>wh", ":split<CR>")
mappings.nnoremap("<leader>wv", ":vsplit<CR>")
mappings.nnoremap("<leader>w=", "<C-W>=")

mappings.nnoremap("<C-c>", "<Esc>")

mappings.nnoremap("<leader>e", ":Ex<CR>")
mappings.nnoremap("<LocalLeader>u", ":UndotreeShow<CR>")
mappings.nnoremap("<LocalLeader>e", function()
    require("nvim-tree").toggle(false, false, vim.fn.getcwd())
end)
mappings.nnoremap("<LocalLeader>pf", ":NvimTreeFindFileToggle<CR>")

mappings.vnoremap("J", ":m '>+1<CR>gv=gv")
mappings.vnoremap("K", ":m '<-2<CR>gv=gv")

mappings.nnoremap("Y", "yg$")
mappings.nnoremap("n", "nzzzv")
mappings.nnoremap("N", "Nzzzv")
mappings.nnoremap("J", "mzJ`z")
mappings.nnoremap("<C-d>", "<C-d>zz")
mappings.nnoremap("<C-u>", "<C-u>zz")

-- Packer.
mappings.nnoremap("<leader>xC", ":PackerClean<CR>")
mappings.nnoremap("<leader>xc", ":PackerCompile<CR>")
mappings.nnoremap("<leader>xi", ":PackerInstall<CR>")
mappings.nnoremap("<leader>xx", ":PackerSync<CR>")

-- Better virtual paste.
mappings.xnoremap("<leader>p", '"_dP')
mappings.inoremap("<C-v>", '<C-o>"+p')
mappings.cnoremap("<C-v>", "<C-r>+")

-- Better yank.
mappings.nnoremap("<leader>y", '"+y')
mappings.vnoremap("<leader>y", '"+y')
mappings.nmap("<leader>Y", '"+Y')

mappings.nnoremap("<leader>d", '"_d')
mappings.vnoremap("<leader>d", '"_d')

mappings.nnoremap("<C-k>", "<cmd>cnext<CR>zz")
mappings.nnoremap("<C-j>", "<cmd>cprev<CR>zz")
mappings.nnoremap("<leader>k", "<cmd>lnext<CR>zz")
mappings.nnoremap("<leader>j", "<cmd>lprev<CR>zz")

-- Format.
mappings.nnoremap("<leader>f", ":Neoformat<CR>")

-- Harpoon.
mappings.nnoremap("<leader>h", function()
    require("harpoon.mark").add_file()
end)
mappings.nnoremap("<C-e>", function()
    require("harpoon.ui").toggle_quick_menu()
end)

mappings.nnoremap("<c-h>", function()
    require("harpoon.ui").nav_file(1)
end)
mappings.nnoremap("<c-t>", function()
    require("harpoon.ui").nav_file(2)
end)
mappings.nnoremap("<c-n>", function()
    require("harpoon.ui").nav_file(3)
end)
mappings.nnoremap("<c-s>", function()
    require("harpoon.ui").nav_file(4)
end)

-- UI.
mappings.nnoremap("<leader>z", function()
    require("zen-mode").toggle {}
end)
mappings.nnoremap("<leader>Z", function()
    require("zen-mode").toggle {
        window = {
            options = {
                number = false, -- disable number column
                relativenumber = false, -- disable relative numbers
            },
        },
    }
end)

-- Tools integration.
mappings.nnoremap("<c-f>", "<cmd>!tmux new-window ~/.local/bin/open-tmux-workspace<CR>", { silent = true })
