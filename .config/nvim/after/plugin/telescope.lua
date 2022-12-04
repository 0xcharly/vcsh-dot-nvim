local set_prompt_to_entry_value = function(prompt_bufnr)
    local entry = require("telescope.actions.state").get_selected_entry()
    if not entry or not type(entry) == "table" then
        return
    end

    require("telescope.actions.state").get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

local actions = require "telescope.actions"
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
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
                ["<CR>"] = actions.select_default,
            },
        },
        path_display = function(opts, path)
            -- Do common substitutions.
            -- Google3 generic.
            path = path:gsub("^/google/src/cloud/[^/]+/[^/]+/google3/", "google3/", 1)
            path = path:gsub("^google3/java/com/google/", "g3/jcg/", 1)
            path = path:gsub("^google3/javatests/com/google/", "g3/jtcg/", 1)
            path = path:gsub("^google3/third_party/", "g3/3rdp/", 1)
            path = path:gsub("^google3/", "g3/", 1)

            -- GMM specific.
            path = path:gsub("^g3/jcg/apps/android/gmm", "agmm/", 1)
            path = path:gsub("^g3/jtcg/apps/android/gmm", "agmm/tests/", 1)

            -- Do truncation. This allows us to combine our custom display formatter with the built-in truncation.
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

local mappings = require "delay.mappings"

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
    require("telescope.builtin").buffers(require("telescope.themes").get_ivy(opts))
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
