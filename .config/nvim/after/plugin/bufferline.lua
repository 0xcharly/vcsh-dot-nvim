require("bufferline").setup {
  highlights = require("catppuccin.groups.integrations.bufferline").get(),
  options = {
    number = "none",
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = "slant",
    diagnostics = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "DiffviewFiles",
        text = "Diff View",
        highlight = "PanelHeading",
        padding = 1,
      },
      { filetype = "flutterToolsOutline" },
    },
  },
}

require("which-key").register({
  name = "+buffers",
  ["<space>"] = {
    function()
      vim.api.nvim_command "BufferLinePick"
    end,
    "Select",
  },
  n = {
    function()
      vim.api.nvim_command "BufferLineCycleNext"
    end,
    "Next",
  },
  p = {
    function()
      vim.api.nvim_command "BufferLineCyclePrev"
    end,
    "Previous",
  },
  m = {
    name = "+move",
    n = {
      function()
        vim.api.nvim_command "BufferLineMoveNext"
      end,
      "Move right",
    },
    p = {
      function()
        vim.api.nvim_command "BufferLineMovePrev"
      end,
      "Move left",
    },
  },
  s = {
    name = "+sort",
    d = {
      function()
        vim.api.nvim_command "BufferLineSortByDirectory"
      end,
      "Sort by directories",
    },
    e = {
      function()
        vim.api.nvim_command "BufferLineSortByExtension"
      end,
      "Sort by extensions",
    },
  },
}, { prefix = "<leader>b" })
