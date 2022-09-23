local set_prompt_to_entry_value = function(prompt_bufnr)
  local entry = require("telescope.actions.state").get_selected_entry()
  if not entry or not type(entry) == "table" then
    return
  end

  require("telescope.actions.state").get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

require("telescope").setup {
  defaults = {
    prompt_prefix = "   ",
    entry_prefix = "   ",
    selection_caret = "  ",
    layout_strategy = "flex",
    color_devicons = true,

    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

    mappings = {
      i = { ["<esc>"] = require("telescope.actions").close },
    },
  },
  extensions = {
    frecency = {
      workspaces = {
        conf = vim.env.DOTFILES,
        project = vim.env.PROJECTS_DIR,
        qmk = vim.fn.expand "~/Developer/qmk_firmware",
        zmk = vim.fn.expand "~/Developer/zmk-config",
        wiki = vim.g.wiki_path,
      },
    },
  },
}

require("telescope").load_extension "file_browser"
require("telescope").load_extension "frecency"
require("telescope").load_extension "fzf"
require("telescope").load_extension "harpoon"

local function frecency()
  require("telescope").extensions.frecency.frecency(require("telescope.themes").get_dropdown {
    border = true,
    previewer = false,
    shorten_path = false,
  })
end

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

local function edit_neovim()
  local opts_with_preview, opts_without_preview

  opts_with_preview = {
    prompt_title = "dotfiles",
    shorten_path = false,
    cwd = "~/.config/nvim",

    layout_strategy = "flex",
    layout_config = {
      width = 0.9,
      height = 0.8,

      horizontal = { width = { padding = 0.15 } },
      vertical = { preview_height = 0.75 },
    },

    mappings = { i = { ["<C-y>"] = false } },

    attach_mappings = function(_, map)
      map("i", "<c-y>", set_prompt_to_entry_value)
      map("i", "<M-c>", function(prompt_bufnr)
        require("telescope.actions").close(prompt_bufnr)
        vim.schedule(function()
          require("telescope.builtin").find_files(opts_without_preview)
        end)
      end)

      return true
    end,
  }

  opts_without_preview = vim.deepcopy(opts_with_preview)
  opts_without_preview.previewer = false

  require("telescope.builtin").find_files(opts_with_preview)
end

local mappings = require "delay.mappings"

mappings.nnoremap("<leader><space><space>", files)
mappings.nnoremap("<leader><space>.", edit_neovim)
mappings.nnoremap("<leader><space>b", require("telescope.builtin").buffers)
mappings.nnoremap("<leader><space>d", require("telescope.builtin").diagnostics)
mappings.nnoremap("<leader><space>e", require("telescope").extensions.file_browser.file_browser)
mappings.nnoremap("<leader><space>f", frecency)
mappings.nnoremap("<leader><space>g", require("telescope.builtin").live_grep)
mappings.nnoremap("<leader><space>m", require("telescope.builtin").man_pages)
mappings.nnoremap("<leader><space>s", workspace_symbols)
mappings.nnoremap("<leader><space>*", require("telescope.builtin").grep_string)
mappings.nnoremap("<leader><space>/", require("telescope.builtin").find_files)
mappings.nnoremap("<leader><space>?", require("telescope.builtin").help_tags)
