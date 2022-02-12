local util = require 'delay.util'

-- Quickly timeout on keycodes and mappings (timeout on mapping is required for
-- which-key.nvim).
vim.o.timeout = true
vim.o.timeoutlen = 200
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 200

-- Display.
vim.opt.mouse = 'a'
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Undo.
vim.opt.undofile = true

-- Invisible characters.
vim.opt.list = true
vim.opt.listchars:append('eol:↴')
-- vim.opt.listchars = {
--   tab = '▸',
--   trail = '∙',
--   space = '∙',
--   eol = '¬',
--   nbsp = '▪',
--   precedes = '⟨',
--   extends = '⟩',
-- }

-- Indentation.
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.textwidth = 80
vim.opt.wrap = false
vim.opt.wrapmargin = 2

-- Search.
vim.o.inccommand = 'nosplit'

vim.opt.formatoptions = {
  ['1'] = true,
  ['2'] = true, -- Use indent from 2nd line of a paragraph
  q = true, -- continue comments with gq'
  c = true, -- Auto-wrap comments using textwidth
  r = true, -- Continue comments when pressing Enter
  n = true, -- Recognize numbered lists
  t = false, -- autowrap lines using text width value
  j = true, -- remove a comment leader when joining lines.
  -- Only break if the line was not longer than 'textwidth' when the insert
  -- started and only at a white character that has been entered during
  -- the current insert command.
  l = true,
  v = true,
}

-- Message output.
vim.opt.shortmess = {
  t = true, -- truncate file messages at start
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
if util.executable 'rg' then
  vim.o.grepprg =
      [[rg --hidden --glob '!.git' --no-heading --smart-case --vimgrep --follow $*]]
  vim.opt.grepformat = vim.opt.grepformat ^ {'%f:%l:%c:%m'}
elseif util.executable 'ag' then
  vim.o.grepprg = [[ag --nogroup --nocolor --vimgrep]]
  vim.opt.grepformat = vim.opt.grepformat ^ {'%f:%l:%c:%m'}
end
