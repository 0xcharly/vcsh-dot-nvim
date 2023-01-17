-- Bootstrap package manager.
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=v9.1.3', -- TODO: change that back when stable is fixed upstream.
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Company ]]
local company = require 'user.utils.company'
company.setup()

-- Set global leader key.
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

require 'lazy'.setup('user.plugins', {
    dev = {
        path = '~/dev',
        patterns = { '0xcharly' },
    },
    install = { colorscheme = { 'primebuddy', 'habamax' } },
    ui = {
        border = 'rounded',
    },
    performance = {
        rtp = {
            disabled_plugins = {
                'health',
                'gzip',
                'matchit',
                'matchparen',
                -- 'netrwPlugin',
                'rplugin',
                'shada',
                'spellfile',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
})

-- Netrw plugin.
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Mouse support.
vim.o.mouse = 'a'

-- No horizontal scroll.
vim.keymap.set('n', '<ScrollWheelLeft>', '<Nop>', { silent = true })
vim.keymap.set('n', '<ScrollWheelRight>', '<Nop>', { silent = true })

-- Window appearance.
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'
vim.wo.cursorline = true

vim.o.breakindent = true
vim.o.undofile = true
vim.o.belloff = 'all'

-- Indentation.
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.textwidth = 80
vim.o.wrap = false

-- Search.
vim.o.incsearch = true
vim.o.ignorecase = true -- Ignore case when searching...
vim.o.smartcase = true -- ... unless there is a capital letter in the query
vim.o.splitright = true -- Prefer windows splitting to the right
vim.o.splitbelow = true -- Prefer windows splitting to the bottom
vim.o.updatetime = 50 -- Make updates happen faster
vim.o.scrolloff = 8 -- Make it so there are always 8 lines below my cursor

vim.opt.formatoptions = vim.opt.formatoptions -- :h fo
    - 'a' -- Auto formatting is BAD.
    - 't' -- Don't auto format my code. I got linters for that.
    + 'q' -- continue comments with gq'.
    + 'c' -- Auto-wrap comments using textwidth.
    - 'o' -- O and o, don't continue comments.
    + 'r' -- But do continue when pressing enter.
    + 'n' -- Indent past the formatlistpat, not underneath it.
    + 'j' -- Auto-remove comments if possible.
    - '2' -- Use indent from 2nd line of a paragraph.

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

-- Keymaps for better default experience.
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Use faster grep alternatives if possible.
if vim.fn.executable 'rg' > 0 then
    vim.o.grepprg = [[rg --hidden --glob '!.git' --no-heading --smart-case --vimgrep --follow $*]]
    vim.opt.grepformat = vim.opt.grepformat ^ { '%f:%l:%c:%m' }
elseif vim.fn.executable 'ag' > 0 then
    vim.o.grepprg = [[ag --nogroup --nocolor --vimgrep]]
    vim.opt.grepformat = vim.opt.grepformat ^ { '%f:%l:%c:%m' }
end

-- [[ Flash on yank ]]
-- See `:help vim.highlight.on_yank()`
local yank_group = vim.api.nvim_create_augroup('HighlightYank', {})
vim.api.nvim_create_autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank {
            higroup = 'IncSearch',
            timeout = 40,
        }
    end,
})

-- [[ Remove trailing whitespaces ]]
local whitespace_group = vim.api.nvim_create_augroup('WhitespaceGroup', {})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = whitespace_group,
    pattern = '*',
    command = '%s/\\s\\+$//e',
})

-- [[ Key bindings ]]
local keymap_opts = { silent = true }

-- Diagnostic keymaps.
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, keymap_opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, keymap_opts)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, keymap_opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, keymap_opts)

-- To use `ALT+{h,j,k,l}` to navigate windows from any mode:
vim.keymap.set('t', '<M-Left>', '<C-\\><C-N><C-w>h', keymap_opts)
vim.keymap.set('t', '<M-Down>', '<C-\\><C-N><C-w>j', keymap_opts)
vim.keymap.set('t', '<M-Up>', '<C-\\><C-N><C-w>k', keymap_opts)
vim.keymap.set('t', '<M-Right>', '<C-\\><C-N><C-w>l', keymap_opts)

-- Make esc leave terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', keymap_opts)

-- Try and make sure to not mangle space items
vim.keymap.set('t', '<S-Space>', '<Space>', keymap_opts)
vim.keymap.set('t', '<C-Space>', '<Space>', keymap_opts)

vim.keymap.set('i', '<M-Left>', '<C-\\><C-N><C-w>h', keymap_opts)
vim.keymap.set('i', '<M-Down>', '<C-\\><C-N><C-w>j', keymap_opts)
vim.keymap.set('i', '<M-Up>', '<C-\\><C-N><C-w>k', keymap_opts)
vim.keymap.set('i', '<M-Right>', '<C-\\><C-N><C-w>l', keymap_opts)
vim.keymap.set('n', '<M-Left>', '<C-w>h', keymap_opts)
vim.keymap.set('n', '<M-Down>', '<C-w>j', keymap_opts)
vim.keymap.set('n', '<M-Up>', '<C-w>k', keymap_opts)
vim.keymap.set('n', '<M-Right>', '<C-w>l', keymap_opts)

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.keymap.set('v', 'J', ":m '>+1<cr>gv=gv", keymap_opts)
vim.keymap.set('v', 'K', ":m '<-2<cr>gv=gv", keymap_opts)

vim.keymap.set('n', 'Y', 'yg$', keymap_opts)
vim.keymap.set('n', 'n', 'nzzzv', keymap_opts)
vim.keymap.set('n', 'N', 'Nzzzv', keymap_opts)
vim.keymap.set('n', 'J', 'mzJ`z', keymap_opts)
vim.keymap.set('n', '<C-d>', '<C-d>zz', keymap_opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', keymap_opts)

-- Better virtual paste.
vim.keymap.set('x', '<leader>p', '"_dP', keymap_opts)
vim.keymap.set('i', '<C-v>', '<C-o>"+p', keymap_opts)
vim.keymap.set('c', '<C-v>', '<C-r>+', keymap_opts)

-- Better yank.
vim.keymap.set('n', '<leader>y', '"+y', keymap_opts)
vim.keymap.set('v', '<leader>y', '"+y', keymap_opts)
vim.keymap.set('n', '<leader>Y', '"+Y', keymap_opts)

-- Better delete.
vim.keymap.set('n', '<leader>d', '"_d', keymap_opts)
vim.keymap.set('v', '<leader>d', '"_d', keymap_opts)

-- Better jumps.
vim.keymap.set('n', '<C-k>', '<cmd>cnext<cr>zz', keymap_opts)
vim.keymap.set('n', '<C-j>', '<cmd>cprev<cr>zz', keymap_opts)
vim.keymap.set('n', '<leader>k', '<cmd>lnext<cr>zz', keymap_opts)
vim.keymap.set('n', '<leader>j', '<cmd>lprev<cr>zz', keymap_opts)

-- Tools integration.
vim.keymap.set('n', '<c-f>', '<cmd>!tmux new-window ~/.local/bin/open-tmux-workspace<cr>', keymap_opts)
