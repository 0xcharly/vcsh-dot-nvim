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

local function workspace_symbols()
    require("telescope.builtin").lsp_dynamic_workspace_symbols {}
end

local mappings = require "delay.mappings"

mappings.nnoremap("<leader>ff", require("fzf-lua").files)
mappings.nnoremap("<C-p>", require("fzf-lua").git_files)
mappings.nnoremap("<leader>g", require("fzf-lua").live_grep)
mappings.nnoremap("<leader>.", function()
    -- require("fzf-lua").files { cwd = "~/.config" }
    require("fzf-lua").files { cmd = "fd . ~/.config --type f --exclude '*.git' --exclude raycast" }
end)
mappings.nnoremap("<leader>b", require("fzf-lua").buffers)
mappings.nnoremap("<leader>d", require("telescope.builtin").diagnostics)
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
    mappings.nnoremap("<LocalLeader>gs", function()
        require("telescope").extensions.codesearch.find_query {}
    end)
    mappings.nnoremap("<LocalLeader>gf", function()
        require("telescope").extensions.codesearch.find_files {}
    end)
end
