local util = require("user.util")
local mappings = require("user.mappings")

-- Quickly timeout on keycodes and mappings.
-- vim.o.timeout = true
-- vim.o.timeoutlen = 500
-- vim.opt.ttimeout = true
-- vim.opt.ttimeoutlen = 500

-- Display.
vim.o.laststatus = 3
vim.opt.mouse = "a"
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Bell.
vim.opt.belloff = "all"

-- Mouse.
vim.opt.mouse = "n"
mappings.nnoremap("<ScrollWheelLeft>", "<nop>")
mappings.nnoremap("<ScrollWheelRight>", "<nop>")

-- Ignore compiled files
vim.opt.wildignore = "__pycache__"
vim.opt.wildignore = vim.opt.wildignore + { "*.o", "*~", "*.pyc", "*pycache*" }

-- Cool floating window popup menu for completion on command line
vim.opt.pumblend = 0
vim.opt.wildmode = "longest:full"
vim.opt.wildoptions = "pum"

-- Undo.
vim.opt.undofile = true

-- Invisible characters.
vim.opt.listchars = {
    tab = "»·",
    trail = "∙",
}
vim.opt.list = true
--   eol = '↴',
--   space = '∙',
--   eol = '¬',
--   nbsp = '▪',
--   precedes = '⟨',
--   extends = '⟩',

-- Indentation.
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.textwidth = 80
vim.opt.wrap = false
vim.opt.wrapmargin = 2

-- Search.
vim.o.inccommand = "split"
vim.opt.incsearch = true
vim.opt.showmatch = true
vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true -- ... unless there is a capital letter in the query
vim.opt.splitright = true -- Prefer windows splitting to the right
vim.opt.splitbelow = true -- Prefer windows splitting to the bottom
vim.opt.updatetime = 50 -- Make updates happen faster
vim.opt.hlsearch = true -- I wouldn't use this without my DoNoHL function
vim.opt.scrolloff = 8 -- Make it so there are always 8 lines below my cursor
vim.opt.signcolumn = "yes"

vim.opt.formatoptions = vim.opt.formatoptions -- :h fo
    - "a" -- Auto formatting is BAD.
    - "t" -- Don't auto format my code. I got linters for that.
    + "q" -- continue comments with gq'
    + "c" -- Auto-wrap comments using textwidth
    - "o" -- O and o, don't continue comments
    + "r" -- But do continue when pressing enter.
    + "n" -- Indent past the formatlistpat, not underneath it.
    + "j" -- Auto-remove comments if possible.
    - "2" -- Use indent from 2nd line of a paragraph

vim.opt.joinspaces = false

-- Message output.
vim.opt.shortmess = {
    t = true, -- truncate file messages at start
    a = true, -- ignore annoying save file messages
    A = true, -- ignore annoying swap file messages
    o = true, -- file-read message overwrites previous
    O = true, -- file-read message overwrites previous
    T = true, -- truncate non-file messages in middle
    f = true, -- (file x of x) instead of just (x of x
    F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
    s = true,
    c = true,
    W = true, -- Dont show [w] or written when writing
}

-- Use faster grep alternatives if possible
if util.executable("rg") then
    vim.o.grepprg = [[rg --hidden --glob '!.git' --no-heading --smart-case --vimgrep --follow $*]]
    vim.opt.grepformat = vim.opt.grepformat ^ { "%f:%l:%c:%m" }
elseif util.executable("ag") then
    vim.o.grepprg = [[ag --nogroup --nocolor --vimgrep]]
    vim.opt.grepformat = vim.opt.grepformat ^ { "%f:%l:%c:%m" }
end

-- Neovide-specific configuration.
vim.cmd([[ let g:neovide_input_macos_alt_is_meta=v:true ]])
vim.cmd([[ let g:neovide_cursor_animation_length=0.05 ]])
vim.cmd([[ let g:neovide_cursor_trail_size=0.2 ]])
