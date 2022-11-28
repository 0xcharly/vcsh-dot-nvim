local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Flash on yank.
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank {
            higroup = "IncSearch",
            timeout = 40,
        }
    end,
})

-- Set the proper file type on ZMK files.
local zmk_home = vim.fn.expand "~/Developer/zmk-config/"
local adjust_filetype_group = augroup("AdjustFiletype", { clear = true })

autocmd({ "BufNewFile", "BufRead" }, {
    group = adjust_filetype_group,
    pattern = { zmk_home .. "*.keymap", zmk_home .. "*.conf", zmk_home .. "*.dtsi", zmk_home .. "*.overlay" },
    command = "set ft=devicetree",
})

-- Remove trailing whitespaces.
local delay_group = augroup("DelayGroup", {})
autocmd({ "BufWritePre" }, {
    group = delay_group,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

local google3_home = "/google/src/cloud/delay/"
local google3_filetype_group = augroup("Google3Filetype", { clear = true })

autocmd({ "BufNewFile", "BufRead" }, {
    group = google3_filetype_group,
    pattern = { google3_home .. "*.java", google3_home .. "*.kt" },
    command = "set sw=2 ts=2 sts=2 tw=100",
})
