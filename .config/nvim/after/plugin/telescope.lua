local telescope = require "telescope"
local actions = require "telescope.actions"
local builtins = require "telescope.builtin"
local themes = require "telescope.themes"
local action_state = require "telescope.actions.state"

local set_prompt_to_entry_value = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == "table" then
    return
  end

  action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

telescope.setup {
  defaults = {
    prompt_prefix = "   ",
    entry_prefix = "   ",
    selection_caret = " ❯ ",
    file_ignore_patterns = { "%.jpg", "%.jpeg", "%.png", "%.otf", "%.ttf" },
    layout_strategy = "flex",
  },
  file_previewer = require("telescope.previewers").vim_buffer_cat.new,
  grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
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
    fzf = {
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
    },
    fzy_native = { override_generic_sorter = true, override_file_sorter = true },
    fzf_writer = { use_highlighter = false, minimum_grep_characters = 6 },
  },
}

telescope.load_extension "file_browser"
telescope.load_extension "frecency"
telescope.load_extension "fzf"
telescope.load_extension "packer"

local function buffers()
  builtins.buffers {
    sort_lastused = true,
    show_all_buffers = true,
    attach_mappings = function(prompt_bufnr, map)
      local delete_buf = function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.api.nvim_buf_delete(selection.bufnr, { force = true })
      end
      map("i", "<c-x>", delete_buf)
      return true
    end,
  }
end

local function frecency()
  telescope.extensions.frecency.frecency(themes.get_dropdown {
    border = true,
    previewer = false,
    shorten_path = false,
  })
end

-- General finds files function which changes the picker depending on the
-- current buffers path.
local function files()
  if vim.fn.isdirectory ".git" > 0 then
    -- If in a git project, use :Telescope git_files
    builtins.git_files()
  else
    -- Otherwise, use :Telescope find_files
    builtins.find_files()
  end
end

local function reloader()
  builtins.reloader(themes.get_dropdown())
end

local function workspace_symbols()
  builtins.lsp_dynamic_workspace_symbols {}
end

local function edit_neovim()
  local opts_with_preview, opts_without_preview

  opts_with_preview = {
    prompt_title = "~ dotfiles ~",
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
        actions.close(prompt_bufnr)
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

local whichKey = require "which-key"
whichKey.register({
  f = {
    name = "+telescope",
    a = {
      function()
        vim.api.nvim_command "Telescope"
      end,
      "Builtins",
    },
    b = { buffers, "Buffers" },
    c = { builtins.git_commits, "Commits" },
    d = { edit_neovim, "Dotfiles" },
    f = { builtins.find_files, "Files" },
    g = { builtins.live_grep, "Grep" },
    h = { frecency, "History" },
    m = { builtins.man_pages, "Man pages" },
    r = { reloader, "Module reloader" },
    t = {
      function()
        vim.api.nvim_command "tabnew"
        files()
      end,
      "Open Telescope in a new tab",
    },
    w = { workspace_symbols, "Workspace symbols", silent = false },
    ["<space>"] = { files, "Smart files" },
    ["?"] = { builtins.help_tags, "Help" },
  },
}, { prefix = "<leader>" })
