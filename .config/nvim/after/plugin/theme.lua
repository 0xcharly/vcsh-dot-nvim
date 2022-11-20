require("nvim-lastplace").setup {}

require("nvim-web-devicons").setup {
    override = {
        [".gitmodules"] = {
            icon = "",
            color = "#41535b",
            cterm_color = "59",
            name = "GitModules",
        },
    },
}

--[[
require("onedarkpro").setup {
    dark_theme = "onedark",
    colors = {
        onedark = {
            bg = "#21252b", -- Darker.
        },
    },
}
vim.cmd [[ colorscheme onedarkpro ]]

local c = require("onedark.palette").darker
require("onedark").setup {
    style = "darker",
    highlights = {
        ["@field"] = { fg = "$fg" },
        ["@variable"] = { fg = "$red" },
        ["@function.builtin"] = { fg = "$orange" },
        DiagnosticHint = { fg = "$grey" },
        DiagnosticVirtualTextHint = {
            bg = require("onedark.util").darken(c.grey, 0.1, c.bg0),
            fg = "$grey",
        },
    },
}
require("onedark").load()

-- require("onedark").setup()
-- local hl = function(highlightGroup, opts)
--     vim.api.nvim_set_hl(0, highlightGroup, opts)
-- end

-- Darker background for better contrast.
-- hl("Normal", { bg = "#21252b" })
-- hl("NormalNC", { bg = "#21252b" })
-- hl("NonText", { bg = "#21252b" })
-- hl("FoldColumn", { bg = "#21252b" })
-- hl("SignColumn", { bg = "#21252b" })
--
-- hl("WildMenu", { bg = "#282c34" })
-- hl("Pmenu", { bg = "#282c34" })
--
-- hl("Visual", { bg = "#31363f" })
-- hl("PmenuSel", { bg = "#31363f" })

-- Catppuccin.
--[[
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

require("catppuccin").setup {
    native_lsp = {
        enabled = true,
        virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
        },
        underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
        },
    },
    integrations = {
        cmp = true,
        gitgutter = true,
        gitsigns = true,
        neogit = true,
        notify = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
    },
}
--]]

--[[
require("lualine").setup {
    options = {
        icons_enabled = false,
        theme = "onedark",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = { "filename", "diagnostics" },
        lualine_x = { "fileformat", "encoding", "filetype", "progress", "location" },
        lualine_y = {},
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
}
--]]

-- vim.cmd [[colorscheme onedark]]
-- vim.cmd [[ hi Normal guibg=#1e222b ]]

-- vim.g.doom_one_terminal_colors = true
-- vim.cmd [[colorscheme catppuccin]]
-- vim.cmd [[colorscheme tokyonight-night]]
-- vim.cmd [[colorscheme onedark]]

---@module "feline"
local feline = require "feline"
---@module "feline.providers.lsp"
local lsp = require "feline.providers.lsp"

local icons = {
    modified = "",
    line_number = "",
    lsp_server = "",
    git = {
        diff_add = "",
        diff_del = "",
        diff_mod = "",
    },
    diagnostic = {
        err = "",
        warn = "",
        info = "",
        hint = "",
    },
}

local path_sep = package.config:sub(1, 1)

---@class ListBufsSpec
---@field loaded boolean Filter out buffers that aren't loaded.
---@field listed boolean Filter out buffers that aren't listed.
---@field no_hidden boolean Filter out buffers that are hidden.
---@field tabpage integer Filter out buffers that are not displayed in a given tabpage.
---@field pattern string Filter out buffers whose name does not match a given lua pattern.
---@field options table<string, any> Filter out buffers that don't match a given map of options.
---@field vars table<string, any> Filter out buffers that don't match a given map of variables.

---@param opt? ListBufsSpec
---@return integer[] #Buffer numbers of matched buffers.
local function list_bufs(opt)
    opt = opt or {}
    local bufs

    if opt.no_hidden or opt.tabpage then
        local wins = opt.tabpage and vim.api.nvim_tabpage_list_wins(opt.tabpage) or vim.api.nvim_list_wins()
        local bufnr
        local seen = {}
        bufs = {}
        for _, winid in ipairs(wins) do
            bufnr = vim.api.nvim_win_get_buf(winid)
            if not seen[bufnr] then
                bufs[#bufs + 1] = bufnr
            end
            seen[bufnr] = true
        end
    else
        bufs = vim.api.nvim_list_bufs()
    end

    return vim.tbl_filter(function(v)
        if opt.loaded and not vim.api.nvim_buf_is_loaded(v) then
            return false
        end

        if opt.listed and not vim.bo[v].buflisted then
            return false
        end

        if opt.pattern and not vim.fn.bufname(v):match(opt.pattern) then
            return false
        end

        if opt.options then
            for name, value in pairs(opt.options) do
                if vim.bo[v][name] ~= value then
                    return false
                end
            end
        end

        if opt.vars then
            for name, value in pairs(opt.vars) do
                if vim.b[v][name] ~= value then
                    return false
                end
            end
        end

        return true
    end, bufs) --[[@as integer[] ]]
end

---Get the result of the union of the given vectors.
---@param ... vector
---@return vector
local function vec_union(...)
    local result = {}
    local args = { ... }
    local seen = {}

    for i = 1, select("#", ...) do
        if type(args[i]) ~= "nil" then
            if type(args[i]) ~= "table" and not seen[args[i]] then
                seen[args[i]] = true
                result[#result + 1] = args[i]
            else
                for _, v in ipairs(args[i]) do
                    if not seen[v] then
                        seen[v] = true
                        result[#result + 1] = v
                    end
                end
            end
        end
    end

    return result
end

---Get the filename with the least amount of path segments necessary to make it
---unique among the currently listed buffers.
---
---Derived from feline.nvim.
---@see [feline.nvim](https://github.com/feline-nvim/feline.nvim)
---@param filename string
---@return string
local function get_unique_file_bufname(filename)
    local basename = vim.fn.fnamemodify(filename, ":t")

    local collisions = vim.tbl_map(function(bufnr)
        return vim.api.nvim_buf_get_name(bufnr)
    end, vec_union(list_bufs { listed = true }, list_bufs { no_hidden = true }))

    collisions = vim.tbl_filter(function(name)
        return name ~= filename and vim.fn.fnamemodify(name, ":t") == basename
    end, collisions)

    -- Reverse filenames in order to compare their names
    filename = string.reverse(filename)
    collisions = vim.tbl_map(string.reverse, collisions) --[[@as string[] ]]

    local idx = 1

    -- For every other filename, compare it with the name of the current file
    -- char-by-char to find the minimum idx `i` where the i-th character is
    -- different for the two filenames After doing it for every filename, get the
    -- maximum value of `i`
    if next(collisions) then
        local delta_indices = vim.tbl_map(function(filename_other)
            for i = 1, #filename do
                -- Compare i-th character of both names until they aren't equal
                if filename:sub(i, i) ~= filename_other:sub(i, i) then
                    return i
                end
            end
            return 1
        end, collisions) --[[@as integer[] ]]
        idx = math.max(unpack(delta_indices))
    end

    -- Iterate backwards (since filename is reversed) until a path sep is found
    -- in order to show a valid file path
    while idx <= #filename do
        if filename:sub(idx, idx) == path_sep then
            idx = idx - 1
            break
        end

        idx = idx + 1
    end

    return string.reverse(string.sub(filename, 1, idx))
end

local function filler_section(size)
    return {
        provider = function()
            return string.rep(" ", size)
        end,
        hl = {
            fg = "NONE",
            bg = "bg",
        },
    }
end

local function extend_comps(components, config)
    return vim.tbl_map(function(comp)
        return vim.tbl_extend("force", comp, config)
    end, components)
end

---Join multiple vectors into one.
---@param ... any
---@return vector
local function vec_join(...)
    local result = {}
    local args = { ... }
    local pos = 0

    for i = 1, select("#", ...) do
        if type(args[i]) ~= "nil" then
            if type(args[i]) ~= "table" then
                result[pos + 1] = args[i]
                pos = pos + 1
            else
                for j, v in ipairs(args[i]) do
                    result[pos + j] = v
                end
                pos = pos + #args[i]
            end
        end
    end

    return result
end

local function str_right_pad(s, min_size, fill)
    if #s >= min_size then
        return s
    end
    if not fill then
        fill = " "
    end
    return s .. string.rep(fill, math.ceil((min_size - #s) / #fill))
end

local function str_left_pad(s, min_size, fill)
    if #s >= min_size then
        return s
    end
    if not fill then
        fill = " "
    end
    return string.rep(fill, math.ceil((min_size - #s) / #fill)) .. s
end

local function str_center_pad(s, min_size, fill)
    if #s >= min_size then
        return s
    end
    if not fill then
        fill = " "
    end
    local left_len = math.floor((min_size - #s) / #fill / 2)
    local right_len = math.ceil((min_size - #s) / #fill / 2)
    return string.rep(fill, left_len) .. s .. string.rep(fill, right_len)
end

local function clamp(value, min, max)
    if value < min then
        return min
    end
    if value > max then
        return max
    end
    return value
end

---@class FelineComponents
local components = {
    block = {
        provider = function()
            return "▊"
        end,
        hl = { fg = "blue" },
    },
    lsp_server = {
        provider = function()
            if #vim.tbl_keys(vim.lsp.buf_get_clients(0)) > 0 then
                return vim.bo.filetype
            end
        end,
        enabled = function()
            local exclude = { [""] = true }
            if exclude[vim.bo.filetype] then
                return false
            end
            return next(vim.lsp.buf_get_clients(0))
        end,
        icon = icons.lsp_server .. " ",
        truncate_hide = true,
        hl = { fg = "violet" },
    },
    file = {
        info = {
            provider = function()
                local uname = get_unique_file_bufname(vim.api.nvim_buf_get_name(0))
                local status = vim.bo.modified and (" " .. icons.modified .. " ") or ""

                local max_size = 51
                local margin = 42
                local width = vim.o.laststatus == 3 and vim.o.columns or vim.api.nvim_win_get_width(0)
                local size = clamp(width - margin, 1, max_size)

                -- Truncate name if it's too long
                if #uname > size then
                    uname = "«" .. uname:sub(math.max(#uname - size, 3))
                end

                return uname .. status
            end,
            enabled = function()
                return vim.fn.bufname() ~= ""
            end,
        },
        filetype = {
            provider = function()
                return string.upper(vim.bo.ft)
            end,
        },
        line_info = {
            provider = function()
                local cursor = vim.api.nvim_win_get_cursor(0)
                local line = tostring(cursor[1])
                if #line % 2 ~= 0 then
                    line = str_left_pad(line, #line + (2 - #line % 2))
                end

                local col = tostring(cursor[2])
                if #col % 2 ~= 0 then
                    col = str_right_pad(col, #col + (2 - #col % 2))
                end

                local result = line .. ":" .. col
                if #result % 4 ~= 0 then
                    result = str_center_pad(result, #result + (4 - #result % 4))
                end

                return result
            end,
            icon = icons.line_number,
            hl = { fg = "grey" },
        },
        line_percent = {
            provider = function()
                local current_line = vim.api.nvim_win_get_cursor(0)[1]
                local total_line = vim.api.nvim_buf_line_count(0)
                local result, _ = math.modf((current_line / total_line) * 100)
                return result .. "%%"
            end,
            hl = { fg = "grey" },
        },
    },
    git = {
        diff_add = {
            provider = "git_diff_added",
            icon = icons.git.diff_add .. " ",
            truncate_hide = true,
            hl = { fg = "green" },
        },
        diff_mod = {
            provider = "git_diff_changed",
            icon = icons.git.diff_mod .. " ",
            truncate_hide = true,
            hl = { fg = "blue" },
        },
        diff_del = {
            provider = "git_diff_removed",
            icon = icons.git.diff_del .. " ",
            truncate_hide = true,
            hl = { fg = "red" },
        },
    },
    diagnostic = {
        err = {
            provider = "diagnostic_errors",
            icon = icons.diagnostic.err .. " ",
            enabled = function()
                return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
            end,
            truncate_hide = true,
            hl = { fg = "red" },
        },
        warn = {
            provider = "diagnostic_warnings",
            icon = icons.diagnostic.warn .. " ",
            enabled = function()
                return lsp.diagnostics_exist(vim.diagnostic.severity.WARNING)
            end,
            truncate_hide = true,
            hl = { fg = "yellow" },
        },
        info = {
            provider = "diagnostic_info",
            icon = icons.diagnostic.info .. " ",
            enabled = function()
                return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
            end,
            truncate_hide = true,
            hl = { fg = "fg" },
        },
        hint = {
            provider = "diagnostic_hints",
            icon = icons.diagnostic.hint .. " ",
            enabled = function()
                return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
            end,
            truncate_hide = true,
            hl = { fg = "grey" },
        },
    },
}

local statusline = {
    active = {
        -- LEFT
        [1] = extend_comps({
            components.block,
            components.file.info,
            components.git.diff_add,
            components.git.diff_mod,
            components.git.diff_del,
        }, { right_sep = " " }),
        -- MIDDLE
        [2] = {},
        -- RIGHT
        [3] = vec_join(
            extend_comps({
                components.diagnostic.err,
                components.diagnostic.warn,
                components.diagnostic.hint,
                components.diagnostic.info,
                components.lsp_server,
                components.file.line_percent,
                components.file.line_info,
            }, { left_sep = " " }),
            { filler_section(1) }
        ),
    },
    inactive = {
        -- LEFT
        [1] = extend_comps({
            components.block,
            components.file.filetype,
            components.file.info,
        }, { right_sep = " " }),
        -- MIDDLE
        [2] = {},
        -- RIGHT
        [3] = {},
    },
}
feline.setup {
    components = statusline,
    force_inactive = {
        filetypes = {
            -- "^NvimTree$",
            -- "^vista$",
            -- "^dbui$",
            -- "^packer$",
            -- "^fugitiveblame$",
            -- "^Trouble$",
            -- "^DiffviewFiles$",
            -- "^DiffviewFileHistory$",
            -- "^DiffviewFHOptionPanel$",
            -- "^Outline$",
            -- "^dashboard$",
            -- "^NeogitStatus$",
            -- "^lir$",
        },
        buftypes = {
            -- "terminal"
        },
        bufnames = {},
    },
}

feline.use_theme {
    bg = c.bg1,
    fg = c.fg,
    yellow = c.yellow,
    cyan = c.cyan,
    darkblue = c.dark_cyan,
    green = c.green,
    orange = c.orange,
    violet = c.purple,
    magenta = c.purple,
    blue = c.blue,
    block = c.blue,
    red = c.red,
}
