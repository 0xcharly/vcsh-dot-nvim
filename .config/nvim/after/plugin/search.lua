local telescope = require("telescope")
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")

telescope.setup({
    defaults = {
        prompt_prefix = "   ",
        entry_prefix = "   ",
        selection_caret = " ❯ ",
        layout_strategy = "vertical",

        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<esc>"] = actions.close,
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
})

telescope.load_extension("fzf")
telescope.load_extension("harpoon")
telescope.load_extension("undo")

local mappings = require("user.mappings")
local fzf_lua = require("fzf-lua")
local builtin = require("telescope.builtin")

mappings.nnoremap("<leader>ff", fzf_lua.files)
mappings.nnoremap("<C-p>", fzf_lua.git_files)
mappings.nnoremap("<leader>g", fzf_lua.live_grep)
mappings.nnoremap("<leader>.", function()
    if vim.fn.executable("fd") == 1 then
        fzf_lua.files({ cmd = "fd . ~/.config --type f --exclude '*.git' --exclude raycast --exclude op" })
    else
        fzf_lua.files({ cwd = "~/.config" })
    end
end)
mappings.nnoremap("<leader>b", builtin.buffers)
mappings.nnoremap("<leader>d", builtin.diagnostics)
mappings.nnoremap("<leader>tm", builtin.man_pages)
mappings.nnoremap("<leader>ts", builtin.lsp_dynamic_workspace_symbols)
mappings.nnoremap("<leader>su", telescope.extensions.undo.undo)
mappings.nnoremap("<leader>*", builtin.grep_string)
mappings.nnoremap("<leader>/", builtin.find_files)
mappings.nnoremap("<leader>?", builtin.help_tags)

if pcall(function() telescope.load_extension("codesearch") end) then
    mappings.nnoremap("<LocalLeader>gs", function() telescope.extensions.codesearch.find_query({}) end)
    mappings.nnoremap("<LocalLeader>gf", function() telescope.extensions.codesearch.find_files({}) end)
end
