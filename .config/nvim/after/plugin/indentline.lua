  require('indent_blankline').setup {
    show_end_of_line = true,
    show_trailing_blankline_indent = false,
    filetype_exclude = {
      'startify', 'dashboard', 'dotooagenda', 'log', 'fugitive', 'gitcommit',
      'packer', 'vimwiki', 'markdown', 'json', 'txt', 'vista', 'help',
      'todoist', 'NvimTree', 'peekaboo', 'git', 'TelescopePrompt', 'undotree',
      'flutterToolsOutline', '', -- for all buffers without a file type
    },
    buftype_exclude = {'terminal', 'nofile'},
    show_current_context = true,
    context_patterns = {
      'class', 'function', 'method', 'block', 'list_literal', 'selector', '^if',
      '^table', 'if_statement', 'while', 'for',
    },
  }
