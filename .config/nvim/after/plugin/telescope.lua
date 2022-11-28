local set_prompt_to_entry_value = function(prompt_bufnr)
    local entry = require("telescope.actions.state").get_selected_entry()
    if not entry or not type(entry) == "table" then
        return
    end

    require("telescope.actions.state").get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

require("telescope").setup {
    defaults = {
        prompt_prefix = "   ",
        entry_prefix = "   ",
        selection_caret = " ❯ ",
        layout_strategy = "vertical",

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<esc>"] = require("telescope.actions").close,
                ["<M-c>"] = function(prompt_bufnr)
                    require("telescope.actions").close(prompt_bufnr)
                end,
            },
        },
        path_display = function(opts, path)
            -- Do common substitutions
            path = path:gsub("^/google/src/cloud/[^/]+/[^/]+/google3/", "google3/", 1)
            path = path:gsub("^google3/java/com/google/", "g3/j/c/g/", 1)
            path = path:gsub("^google3/javatests/com/google/", "g3/jt/c/g/", 1)
            path = path:gsub("^google3/third_party/", "g3/3rdp/", 1)
            path = path:gsub("^google3/", "g3/", 1)

            -- Do truncation. This allows us to combine our custom display formatter
            -- with the built-in truncation.
            -- `truncate` handler in transform_path memoizes computed truncation length in opts.__length.
            -- Here we are manually propagating this value between new_opts and opts.
            -- We can make this cleaner and more complicated using metatables :)
            local new_opts = {
                path_display = {
                    truncate = true,
                },
                __length = opts.__length,
            }
            path = require("telescope.utils").transform_path(new_opts, path)
            opts.__length = new_opts.__length
            return path
        end,
    },
    pickers = {
        find_files = {
            disable_devicons = true,
        },
    },
    extensions = {
        codesearch = {
            disable_devicons = true,
        },
    },
}

require("telescope").load_extension "file_browser"
require("telescope").load_extension "fzf"
require("telescope").load_extension "git_worktree"
require("telescope").load_extension "harpoon"

-- General finds files function which changes the picker depending on the
-- current buffers path.
local function files()
    local opts = {
        prompt_title = "git ls-files",
    } -- define here if you want to define something
    local ok = pcall(require("telescope.builtin").git_files, opts)
    if not ok then
        opts.prompt_title = "files"
        require("telescope.builtin").find_files(opts)
    end
end

local function workspace_symbols()
    require("telescope.builtin").lsp_dynamic_workspace_symbols {}
end

local function edit_dotfiles()
    local opts_with_preview, opts_without_preview

    opts_with_preview = {
        prompt_title = "dotfiles",
        shorten_path = false,
        cwd = "~/.config",

        layout_strategy = "flex",
        layout_config = {
            width = 0.9,
            height = 0.8,

            horizontal = { width = { padding = 0.15 } },
            vertical = { preview_height = 0.75 },
        },
    }

    opts_without_preview = vim.deepcopy(opts_with_preview)
    opts_without_preview.previewer = false

    require("telescope.builtin").find_files(opts_with_preview)
end

-- FZF
vim.g.fzf_colors = {
    fg = { "fg", "Normal" },
    bg = { "bg", "Normal" },
    hl = { "fg", "Function" },
    ["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" },
    ["bg+"] = { "bg", "CursorLine", "Normal" },
    ["hl+"] = { "fg", "Function" },
    info = { "fg", "Comment" },
    gutter = { "bg", "normal" },
    border = { "fg", "Ignore" },
    prompt = { "fg", "Comment" },
    pointer = { "fg", "Label" },
    marker = { "fg", "Keyword" },
    spinner = { "fg", "Label" },
    header = { "fg", "Comment" },
}

vim.api.nvim_exec(
    [[
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --hidden --column --no-line-number --no-heading --color=never --smart-case --glob "!{.git,node_modules,flow-typed}" -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command, '--pointer', '❯']}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

function! SmartFiles(query, fullscreen)
    let spec = {'options': ['--query', a:query, '--pointer', '❯']}
    call fzf#vim#files(a:query, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

function! GitFiles(query, fullscreen)
    let spec = {'options': ['--query', a:query, '--pointer', '❯']}
    call fzf#vim#gitfiles(getcwd(), fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RipGrep call RipgrepFzf(<q-args>, <bang>0)
command! -bang -nargs=? -complete=dir SmartFiles call SmartFiles(<q-args>, <bang>0)
command! -bang -nargs=? -complete=dir GitFiles call GitFiles(<q-args>, <bang>0)
]],
    ""
)

local mappings = require "delay.mappings"

-- mappings.nnoremap("<leader>c", ":SmartFiles<CR>")
-- mappings.nnoremap("<leader>r", ":GitFiles<CR>")
-- mappings.nnoremap("<leader>g", ":RipGrep<CR>")

mappings.nnoremap("<leader>c", files)
mappings.nnoremap("<leader>g", require("telescope.builtin").live_grep)
mappings.nnoremap("<leader>.", edit_dotfiles)
mappings.nnoremap("<leader>b", function(opts)
    opts = opts or {}
    opts.attach_mappings = function(prompt_bufnr, map)
        local delete_buf = function()
            local selection = require("telescope.actions.state").get_selected_entry()
            require("telescope.actions").close(prompt_bufnr)
            vim.api.nvim_buf_delete(selection.bufnr, { force = true })
        end
        map("i", "<c-u>", delete_buf)
        return true
    end
    opts.previewer = false
    -- define more opts here
    -- opts.show_all_buffers = true
    -- opts.sort_lastused = true
    -- opts.shorten_path = false
    require("telescope.builtin").buffers(require("telescope.themes").get_dropdown(opts))
end)
mappings.nnoremap("<leader>td", require("telescope.builtin").diagnostics)
mappings.nnoremap("<leader>te", require("telescope").extensions.file_browser.file_browser)
mappings.nnoremap("<leader>tm", require("telescope.builtin").man_pages)
mappings.nnoremap("<leader>tw", require("telescope").extensions.git_worktree.git_worktrees)
mappings.nnoremap("<leader>ts", workspace_symbols)
mappings.nnoremap("<leader>*", require("telescope.builtin").grep_string)
mappings.nnoremap("<leader>/", require("telescope.builtin").find_files)
mappings.nnoremap("<leader>?", require("telescope.builtin").help_tags)

if pcall(function()
    require("telescope").load_extension "codesearch"
end) then
    mappings.nnoremap("<leader>cs", function()
        require("telescope").extensions.codesearch.find_query {}
    end)
    mappings.nnoremap("<leader>cf", function()
        require("telescope").extensions.codesearch.find_files {}
    end)
end
