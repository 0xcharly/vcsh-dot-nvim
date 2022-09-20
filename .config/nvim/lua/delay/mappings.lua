local function bind(op, outer_opts)
  outer_opts = outer_opts or { noremap = true }
  return function(lhs, rhs, opts)
    opts = vim.tbl_extend("force",
      outer_opts,
      opts or {}
    )
    vim.keymap.set(op, lhs, rhs, opts)
  end
end

local nmap = bind("n", { noremap = false })
local nnoremap = bind("n")
local vnoremap = bind("v")
local xnoremap = bind("x")
local inoremap = bind("i")
local tnoremap = bind("t")

-- To use `ALT+{h,j,k,l}` to navigate windows from any mode:
tnoremap("<M-Left>", "<C-\\><C-N><C-w>h")
tnoremap("<M-Down>", "<C-\\><C-N><C-w>j")
tnoremap("<M-Up>", "<C-\\><C-N><C-w>k")
tnoremap("<M-Right>", "<C-\\><C-N><C-w>l")
inoremap("<M-Left>", "<C-\\><C-N><C-w>h")
inoremap("<M-Down>", "<C-\\><C-N><C-w>j")
inoremap("<M-Up>", "<C-\\><C-N><C-w>k")
inoremap("<M-Right>", "<C-\\><C-N><C-w>l")
nnoremap("<M-Left>", "<C-w>h")
nnoremap("<M-Down>", "<C-w>j")
nnoremap("<M-Up>", "<C-w>k")
nnoremap("<M-Right>", "<C-w>l")
nnoremap("<M-S-Left>", ":tabprev<CR>")
nnoremap("<M-S-Right>", ":tabnext<CR>")
tnoremap("<M-S-Left>", "<C-\\><C-N>:tabprev<CR>")
tnoremap("<M-S-Right>", "<C-\\><C-N>:tabnext<CR>")

-- Better virtual paste.
xnoremap("<leader>p", "\"_dP")

-- Better yank.
nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nmap("<leader>Y", "\"+Y")
