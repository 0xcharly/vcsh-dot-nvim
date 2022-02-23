return function()
  local colorscheme = require 'delay.plugins.colorscheme'
  local scale = colorscheme.scale
  local theme = colorscheme.theme
  local util = colorscheme.util

  -- vim.cmd [[ hi clear ]]
  -- vim.cmd [[ syntax reset ]]
  vim.o.termguicolors = true
  vim.o.background = 'dark'
  vim.g.colors_name = 'delay'

  -- Terminal ANSI colors.

  vim.g.terminal_color_0 = theme.ansi.black
  vim.g.terminal_color_8 = theme.ansi.blackBright
  vim.g.terminal_color_1 = theme.ansi.red
  vim.g.terminal_color_9 = theme.ansi.redBright
  vim.g.terminal_color_2 = theme.ansi.green
  vim.g.terminal_color_10 = theme.ansi.greenBright
  vim.g.terminal_color_3 = theme.ansi.yellow
  vim.g.terminal_color_11 = theme.ansi.yellowBright
  vim.g.terminal_color_4 = theme.ansi.blue
  vim.g.terminal_color_12 = theme.ansi.blueBright
  vim.g.terminal_color_5 = theme.ansi.magenta
  vim.g.terminal_color_13 = theme.ansi.magentaBright
  vim.g.terminal_color_6 = theme.ansi.cyan
  vim.g.terminal_color_14 = theme.ansi.cyanBright
  vim.g.terminal_color_7 = theme.ansi.white
  vim.g.terminal_color_15 = theme.ansi.whiteBright

  -- Editor colors.

  local Color, c, Group, g, s = require('colorbuddy').setup()

  Color.new('green', scale.green.shade3)
  Color.new('yellow', scale.yellow.shade3)
  Color.new('cyan', theme.ansi.cyan)
  Color.new('brightYellow', scale.yellow.shade2)
  Color.new('brightMagenta', '#dcbdfb')
  Color.new('orange', '#d18616')

  Color.new('fg', theme.fg.default)
  Color.new('fgMuted', theme.fg.muted)
  Color.new('fgOnEmphasis', theme.fg.onEmphasis)
  Color.new('whitespace', scale.gray.shade7)

  Color.new('canvas', theme.canvas.default)
  Color.new('gutterBg', theme.canvas.default)
  Color.new('selectionBg', theme.accent.muted)
  Color.new('activeLineBg', theme.neutral.subtle)

  Color.new('border', theme.border.default)
  Color.new('cursor', theme.fg.default)

  Color.new('lineNr', theme.fg.subtle)
  Color.new('lineNrCursor', theme.fg.default)

  Color.new('hl', theme.searchKeyword.hl)

  -- Roles.
  Color.new('roleNeutral', theme.neutral.emphasis)
  Color.new('roleNeutralBg', theme.neutral.subtle)
  Color.new('roleAccent', theme.accent.onCanvas)
  Color.new('roleAccentBg', theme.accent.subtle)
  Color.new('roleSuccess', theme.success.onCanvas)
  Color.new('roleSuccessBg', theme.success.subtle)
  Color.new('roleAttention', theme.attention.onCanvas)
  Color.new('roleAttentionBg', theme.attention.subtle)
  Color.new('roleSevere', theme.severe.onCanvas)
  Color.new('roleSevereBg', theme.severe.subtle)
  Color.new('roleDanger', theme.danger.onCanvas)
  Color.new('roleDangerBg', theme.danger.subtle)
  Color.new('roleURI', scale.blue.shade2)

  -- Syntax.
  Color.new('syntaxComment', scale.gray.shade3)
  Color.new('syntaxConstant', scale.blue.shade2)
  Color.new('syntaxFunction', scale.purple.shade2)
  Color.new('syntaxEntity', theme.fg.default)
  Color.new('syntaxEntityTag', scale.green.shade1)
  Color.new('syntaxKeyword', scale.red.shade3)
  Color.new('syntaxLiteral', scale.blue.shade2)
  Color.new('syntaxPreprocessor', scale.purple.shade2)
  Color.new('syntaxPunctuation', theme.neutral.emphasis)
  Color.new('syntaxString', scale.blue.shade1)
  Color.new('syntaxType', scale.blue.shade2)
  Color.new('syntaxVariable', theme.fg.default)

  Color.new('syntaxSpecial', scale.orange.shade1)
  Color.new('syntaxParam', theme.fg.default)

  -- Popup menu.
  Color.new('pmenuBg', theme.canvas.overlay)
  Color.new('pmenuBorder', scale.gray.shade5)
  Color.new('pmenuSelect', '#373e47')
  Color.new('pmenuSbar', '#363b44')

  -- Diff.
  Color.new('diffAdd', theme.success.onCanvas)
  Color.new('diffAddSign', theme.success.emphasis)
  Color.new('diffAddLineBg', theme.success.subtle)
  Color.new('diffAddWordBg', theme.success.muted)
  Color.new('diffChange', theme.attention.onCanvas)
  Color.new('diffChangeSign', theme.attention.emphasis)
  Color.new('diffChangeLineBg', theme.attention.subtle)
  Color.new('diffChangeWordBg', theme.attention.muted)
  Color.new('diffDelete', theme.danger.onCanvas)
  Color.new('diffDeleteSign', theme.danger.emphasis)
  Color.new('diffDeleteLineBg', theme.danger.subtle)
  Color.new('diffDeleteWordBg', theme.danger.muted)

  ------------
  -- Groups --
  ------------

  Group.new('ColorColumn', nil, c.activeLineBg) -- used for the columns set with 'colorcolumn'
  Group.new('Conceal', c.roleNeutral) -- placeholder characters substituted for concealed text (see 'conceallevel')
  Group.new('Cursor', c.canvas, c.cursor) -- character under the cursor
  Group.new('lCursor', c.canvas, c.cursor) -- the character under the cursor when |language-mapping| is used (see 'guicursor')
  Group.new('CursorIM', c.canvas, c.cursor) -- like Cursor, but used when in IME mode |CursorIM|
  Group.new('CursorColumn', nil, c.activeLineBg) -- Screen-column at the cursor, when 'cursorcolumn' is set.
  Group.new('CursorLine', nil, c.activeLineBg) -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
  Group.new('Directory', c.roleAccent) -- directory names (and other special names in listings)
  Group.new('DiffAdd', nil, c.diffAddLineBg) -- diff mode: Added line |diff.txt|
  Group.new('DiffChange', nil, c.diffChangeLineBg) -- diff mode: Changed line |diff.txt|
  Group.new('DiffDelete', nil, c.diffDeleteLineBg) -- diff mode: Deleted line |diff.txt|
  Group.new('DiffText', c.roleNeutral) -- diff mode: Changed text within a changed line |diff.txt|
  Group.new('EndOfBuffer', c.whitespace) -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
  -- TermCursor  = { }, -- cursor in a focused terminal
  -- TermCursorNC= { }, -- cursor in an unfocused terminal
  Group.new('ErrorMsg', c.roleDanger) -- error messages on the command line
  Group.new('VertSplit', c.border) -- the column separating vertically split windows
  Group.new('Folded', c.fg, c.selectionBg) -- line used for closed folds
  Group.new('FoldColumn', c.fg, c.selectionBg) -- 'foldcolumn'
  Group.new('SignColumn', c.roleNeutral, c.canvas) -- column where |signs| are displayed
  Group.new('SignColumnSB', c.roleNeutral, c.canvas) -- column where |signs| are displayed
  Group.new('Substitute', c.roleAccent, c.pmenuBg, s.italic) -- |:substitute| replacement text highlighting
  Group.new('LineNr', c.lineNr) -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
  Group.new('CursorLineNr', c.lineNrCursor) -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
  Group.new('MatchParen', c.fg, c.hl, s.underline + s.bold) -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
  Group.new('ModeMsg', c.fg, nil, s.bold) -- 'showmode' message (e.g., "-- INSERT -- ")
  Group.new('MsgArea', c.fg) -- Area for messages and cmdline
  -- MsgSeparator= { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
  Group.new('MoreMsg', c.roleAccent) -- |more-prompt|
  Group.new('NonText', c.whitespace) -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
  Group.new('Normal', c.fg, c.canvas) -- normal text
  Group.new('NormalNC', c.fg, c.canvas) -- normal text in non-current windows
  Group.new('NormalSB', c.fg, c.canvas) -- normal text in non-current windows
  Group.new('NormalFloat', c.fg, c.pmenuBg) -- Normal text in floating windows.
  Group.new('FloatBorder', c.pmenuBorder, c.pmenuBg)
  -- Group.new('FloatShadow', nil, c.canvas)
  -- Group.new('FloatShadowThrough', nil, c.canvas)
  Group.new('PMenu', c.fg, c.pmenuBg) -- Popup menu: normal item.
  Group.new('PMenuSel', c.fg, c.pmenuSelect) -- Popup menu: selected item.
  Group.new('PMenuSbar', nil, c.pmenuBg) -- Popup menu: scrollbar.
  Group.new('PMenuThumb', nil, c.pmenuSbar) -- Popup menu: Thumb of the scrollbar.
  Group.new('Question', c.roleAccent) -- |hit-enter| prompt and yes/no questions
  Group.new('QuickFixLine', nil, c.pmenuSelect, s.bold) -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
  Group.new('Search', nil, c.hl) -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
  Group.link('IncSearch', g.Search) -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
  Group.new('SpecialKey', c.roleNeutral) -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
  Group.new('SpellBad', nil, nil, s.undercurl, c.roleDanger) -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
  Group.new('SpellCap', nil, nil, s.undercurl, c.roleAttention) -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
  Group.new('SpellLocal', nil, nil, s.undercurl, c.roleAccent) -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
  Group.new('SpellRare', nil, nil, s.undercurl, c.roleNeutral) -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
  Group.new('StatusLine', c.canvas, c.roleAccentBg) -- status line of current window
  Group.new('StatusLineNC', c.fg, c.canvas) -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
  Group.new('TabLine', c.fg, c.canvas) -- tab pages line, not active tab page label
  Group.new('TabLineFill', nil, c.pmenuBg) -- tab pages line, where there are no labels
  Group.new('TabLineSel', c.pmenuSelect, c.roleAccent) -- tab pages line, active tab page label
  Group.new('Title', c.syntaxVariable, nil, s.bold) -- titles for output from ":set all", ":autocmd" etc.
  Group.new('Visual', nil, c.selectionBg) -- Visual mode selection
  Group.new('VisualNOS', nil, c.selectionBg) -- Visual mode selection when vim is "Not Owning the Selection".
  Group.new('WarningMsg', c.roleAttention) -- warning messages
  Group.new('Whitespace', c.whitespace, c.canvas) -- "nbsp", "space", "tab" and "trail" in 'listchars'
  Group.new('WildMenu', nil, c.pmenuSelect) -- current match in 'wildmenu' completion

  -- These groups are not listed as default vim groups, but they are defacto
  -- standard group names for syntax highlighting.
  -- Commented out groups should chain up to their "preferred" group by default,
  -- Uncomment and edit if you want more specific syntax highlighting.

  Group.new('Comment', c.syntaxComment, nil, s.italic) -- any comment
  Group.new('Constant', c.syntaxConstant) -- (preferred) any constant
  Group.new('String', c.syntaxString) -- a string constant: "this is a string"
  Group.new('Character', c.syntaxVariable) --  a character constant: 'c', '\n'
  -- Group.link('Number', g.Character) -- a number constant: 234, 0xff
  -- Group.link('Boolean', g.Character) -- a boolean constant: TRUE, false
  -- Group.link('Float', g.Character) -- a floating point constant: 2.3e10

  Group.new('Identifier', c.syntaxVariable) -- (preferred) any variable name
  Group.new('Function', c.syntaxFunction) -- function name (also: methods for classes)
  Group.new('Statement', c.syntaxKeyword) --  (preferred) any statement
  -- Group.link('Conditional', g.Statement) -- if, then, else, endif, switch, etc.
  -- Group.link('Repeat', g.Statement) -- for, do, while, etc.
  -- Group.link('Label', g.Statement) -- case, default, etc.
  Group.new('Operator', c.syntaxKeyword) -- "sizeof", "+", "*", etc.
  Group.new('Keyword', c.syntaxKeyword, nil, s.italic) --  any other keyword
  -- Group.link('Exception', g.Keyword) -- try, catch, throw

  Group.new('PreProc', c.syntaxPreprocessor) -- (preferred) generic preprocessor
  -- Group.link('Include', g.PreProc) -- preprocessor #include
  -- Group.link('Define', g.PreProc) -- preprocessor #define
  -- Group.link('Macro', g.PreProc) -- same as Define
  -- Group.link('PreCondit', g.PreProc) -- preprocessor #if, #else, #endif, etc.

  Group.new('Type', c.syntaxType) -- (preferred) int, long, char, etc…
  -- Group.link('StorageClass', g.Type) -- static, register, volatile, etc.
  -- Group.link('Structure', g.Type) -- struct, union, enum, etc.
  -- Group.link('Typedef', g.Type) -- A typedef

  Group.new('Special', c.syntaxSpecial) -- (preferred) any special symbol
  -- Group.link('SpecialChar', g.Special) -- special character in a constant
  -- Group.link('Tag', g.Special) -- you can use CTRL-] on this
  -- Group.link('Delimiter', g.Normal) -- character that needs attention
  -- Group.link('SpecialComment', g.Special) -- special things inside a comment
  -- Group.link('Debug', g.Special) -- debugging statements

  Group.new('Underline', nil, nil, s.underline)
  Group.new('Bold', nil, nil, s.bold)
  Group.new('Italic', nil, nil, s.italic)
  -- ("Ignore", below, may be invisible...)
  -- Ignore = { }, -- (preferred) left blank, hidden  |hl-Ignore|

  -- Vim Help Highlighting
  Group.new('helpCommand', c.roleAccent)
  Group.new('helpExample', c.roleNeutral)
  Group.link('helpHeader', g.Title)
  Group.new('helpSectionDelim', c.fgMuted)
  Group.new('helpHyperTextJump', c.roleURI, nil, s.underline)

  Group.new('Error', c.roleDanger) -- (preferred) any erroneous construct
  Group.new('Todo', c.roleAttention, nil, s.italic) -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
  Group.new('qfLineNr', c.lineNr)
  Group.new('qfFileName', c.roleAccent)

  -- mkdCode = { bg = c.bg2, fg = c.fg },
  -- mkdHeading = { fg = c.orange, style = "bold" },
  -- mkdLink = { fg = c.roleAccent, style = "underline" },
  Group.new('mkdCodeDelimiter', c.fg)
  Group.new('mkdCodeStart', c.syntaxVariable, nil, s.bold)
  Group.new('mkdCodeEnd', c.syntaxVariable, nil, s.bold)
  Group.new('markdownHeadingDelimiter', c.syntaxVariable, nil, s.bold)
  Group.new('markdownH1', c.syntaxVariable, nil, s.bold)
  Group.new('markdownH2', c.syntaxVariable, nil, s.bold)
  Group.new('markdownH3', c.syntaxVariable, nil, s.bold)
  Group.new('markdownLinkText', c.fg, nil, s.underline)
  Group.new('markdownUrl', c.fg, nil, s.underline)

  Group.new('debugPC', nil, c.canvas) -- used for highlighting the current line in terminal-debug
  Group.new('debugBreakpoint', c.roleAccent, c.roleAccentBg) -- used for breakpoint colors in terminal-debug
  -- These groups are for the native LSP client. Some other LSP clients may
  -- use these groups, or use their own. Consult your LSP client's
  -- documentation.
  Group.new('LspReferenceText', nil, c.lsp.referenceText) -- used for highlighting "text" references
  Group.new('LspReferenceRead', nil, c.lsp.referenceText) -- used for highlighting "read" references
  Group.new('LspReferenceWrite', nil, c.lsp.referenceText) -- used for highlighting "write" references
  Group.new('LspDiagnosticsDefaultError', c.roleDanger) -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
  Group.new('LspDiagnosticsDefaultWarning', c.roleAttention) -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
  Group.new('LspDiagnosticsDefaultInformation', c.roleAccent) -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
  Group.new('LspDiagnosticsDefaultHint', c.roleNeutral) -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
  Group.new('LspDiagnosticsVirtualTextError', c.roleDanger, c.roleDangerBg) -- Used for "Error" diagnostic virtual text
  Group.new('LspDiagnosticsVirtualTextWarning', c.roleAttention,
            c.roleAttentionBg) -- Used for "Warning" diagnostic virtual text
  Group.new('LspDiagnosticsVirtualTextInformation', c.roleAccent, c.roleAccentBg) -- Used for "Information" diagnostic virtual text
  Group.new('LspDiagnosticsVirtualTextHint', c.roleNeutral, c.roleNeutralBg) -- Used for "Hint" diagnostic virtual text
  Group.new('LspDiagnosticsUnderlineError', nil, nil, s.undercurl, c.roleDanger) -- Used to underline "Error" diagnostics
  Group.new('LspDiagnosticsUnderlineWarning', nil, nil, s.undercurl,
            c.roleAttention) -- Used to underline "Warning" diagnostics
  Group.new('LspDiagnosticsUnderlineInformation', nil, nil, s.undercurl,
            c.roleAccent) -- Used to underline "Information" diagnostics
  Group.new('LspDiagnosticsUnderlineHint', nil, nil, s.undercurl, c.roleNeutral) -- Used to underline "Hint" diagnostics

  Group.link('DiagnosticError', g.LspDiagnosticsDefaultError)
  Group.link('DiagnosticWarn', g.LspDiagnosticsDefaultWarning)
  Group.link('DiagnosticInfo', g.LspDiagnosticsDefaultInformation)
  Group.link('DiagnosticHint', g.LspDiagnosticsDefaultHint)
  Group.link('DiagnosticUnderlineError', g.LspDiagnosticsUnderlineError) -- Used to underline "Error" diagnostics
  Group.link('DiagnosticUnderlineWarn', g.LspDiagnosticsUnderlineWarning) -- Used to underline "Warning" diagnostics
  Group.link('DiagnosticUnderlineInfo', g.LspDiagnosticsUnderlineInformation) -- Used to underline "Information" diagnostics
  Group.link('DiagnosticUnderlineHint', g.LspDiagnosticsVirtualTextHint) -- Used to underline "Hint" diagnostics

  -- LspDiagnosticsFloatingError         = { }, -- Used to color "Error" diagnostic messages in diagnostics float
  -- LspDiagnosticsFloatingWarning       = { }, -- Used to color "Warning" diagnostic messages in diagnostics float
  -- LspDiagnosticsFloatingInformation   = { }, -- Used to color "Information" diagnostic messages in diagnostics float
  -- LspDiagnosticsFloatingHint          = { }, -- Used to color "Hint" diagnostic messages in diagnostics float

  -- LspDiagnosticsSignError             = { }, -- Used for "Error" signs in sign column
  -- LspDiagnosticsSignWarning           = { }, -- Used for "Warning" signs in sign column
  -- LspDiagnosticsSignInformation       = { }, -- Used for "Information" signs in sign column
  -- LspDiagnosticsSignHint              = { }, -- Used for "Hint" signs in sign column

  ---------------------
  -- Plugins support --
  ---------------------

  -- Neovim tree-sitter highlights.
  --
  -- By default, most of these groups link to an appropriate Vim group,
  -- TSError -> Error for example, so you do not have to define these unless
  -- you explicitly want to support Treesitter's improved syntax awareness.
  -- See https://github.com/nvim-treesitter/nvim-treesitter/blob/master/doc/nvim-treesitter.txt

  Group.new('TSAttribute', c.syntaxPreprocessor) -- Annotations that can be attached to the code to denote some kind of meta information. e.g. C++/Dart attributes.
  Group.new('TSBoolean', c.syntaxLiteral) -- Boolean literals: `True` and `False` in Python.
  Group.new('TSCharacter', c.syntaxLiteral) -- Character literals: `'a'` in C.
  Group.new('TSComment', c.syntaxComment, nil, s.italic) -- Line comments and block comments.
  -- TSConditional       = { };    -- Keywords related to conditionals: `if`, `when`, `cond`, etc.
  Group.new('TSConstant', c.fg) -- Constants identifiers. These might not be semantically constant.  E.g. uppercase variables in Python.
  Group.new('TSConstBuiltin', c.syntaxSpecial, nil, s.italic) -- Built-in constant values: `nil` in Lua.
  Group.new('TSConstMacro', c.syntaxSpecial, nil, s.italic) -- Constants defined by macros: `NULL` in C.
  Group.new('TSConstructor', c.syntaxVariable) -- Constructor calls and definitions: `{}` in Lua, and Java constructors.
  -- TSError             = { };    -- Syntax/parser errors. This might highlight large sections of code while the user is typing still incomplete code, use a sensible highlight.
  -- TSException         = { };    -- Exception related keywords: `try`, `except`, `finally` in Python.
  Group.new('TSField', c.fg) -- Object and struct fields.
  -- TSFloat             = { };    -- Floating-point number literals.
  Group.new('TSFunction', c.syntaxFunction) -- Function calls and definitions.
  -- TSFuncBuiltin       = { };    -- Built-in functions: `print` in Lua.
  Group.new('TSFuncMacro', c.fg) -- Macro defined functions (calls and definitions): each `macro_rules` in Rust.
  Group.new('TSInclude', c.syntaxPreprocessor) -- File or module inclusion keywords: `#include` in C, `use` or `extern crate` in Rust.
  Group.new('TSKeyword', c.syntaxKeyword) -- Keywords that don't fit into other categories.
  Group.new('TSKeywordFunction', c.syntaxKeyword) -- Keywords used to define a function: `function` in Lua, `def` and `lambda` in Python.
  -- TSKeywordOperator   = { }; -- Unary and binary operators that are English words: `and`, `or` in Python; `sizeof` in C.
  Group.new('TSKeywordReturn', c.syntaxKeyword, nil, s.italic) -- Keywords like `return` and `yield`.
  Group.new('TSLabel', c.roleAccent) -- GOTO labels: `label:` in C, and `::label::` in Lua.
  -- TSMethod            = { };    -- Method calls and definitions.
  Group.new('TSNamespace', c.fg) -- Identifiers referring to modules and namespaces.
  -- TSNone              = { };    -- No highlighting (sets all highlight arguments to `NONE`). this group is used to clear certain ranges, for example, string interpolations. Don't change the values of this highlight group.
  -- TSNumber            = { };    -- Numeric literals that don't fit into other categories.
  Group.new('TSOperator', c.syntaxKeyword) -- Binary or unary operators: `+`, and also `->` and `*` in C.
  Group.new('TSParameter', c.syntaxParam) -- Parameters of a function.
  -- TSParameterReference= { };    -- References to parameters of a function.
  Group.new('TSProperty', c.syntaxEntity) -- Same as `TSField`.
  Group.new('TSPunctDelimiter', c.syntaxPunctuation) -- Punctuation delimiters: Periods, commas, semicolons, etc.
  Group.new('TSPunctBracket', c.syntaxPunctuation) -- Brackets, braces, parentheses, etc.
  Group.new('TSPunctSpecial', c.fg) -- Special punctuation that doesn't fit into the previous categories.
  -- TSRepeat            = { };    -- Keywords related to loops: `for`, `while`, etc.
  Group.new('TSString', c.syntaxString) -- String literals.
  Group.new('TSStringRegex', c.syntaxVariable) -- Regular expression literals.
  Group.new('TSStringEscape', c.syntaxLiteral) -- Escape characters within a string: `\n`, `\t`, etc.
  -- TSStringSpecial     = { };    -- Strings with special meaning that don't fit into the previous categories.
  -- TSSymbol            = { };    -- Identifiers referring to symbols or atoms.
  Group.new('TSTag', c.syntaxEntityTag) -- Tags like HTML tag names.
  -- TSTagAttribute      = { };    -- HTML tag attributes.
  Group.new('TSTagDelimiter', c.fg) -- Tag delimiter like `<` `>` `/`
  -- TSText              = { };    -- Non-structured text. Like text in a markup language.
  -- TSStrong            = { };    -- Text to be represented in bold.
  -- TSEmphasis          = { };    -- Text to be represented with emphasis.
  -- TSUnderline         = { };    -- Text to be represented with an underline.
  -- TSStrike            = { };    -- Strikethrough text.
  -- TSTitle             = { },    -- Text that is part of a title.
  -- TSLiteral           = { };    -- Literal or verbatim text.
  Group.new('TSURI', c.roleURI, nil, s.underline) -- URIs like hyperlinks or email addresses.
  -- TSMath              = { };    -- Math environments like LaTeX's `$ ... $`
  Group.new('TSTextReference', c.roleAccent) -- Footnotes, text references, citations, etc.
  -- TSEnvironment       = { };    -- Text environments of markup languages.
  -- TSEnvironmentName   = { };    -- Text/string indicating the type of text environment. Like the name of a `\begin` block in LaTeX.
  Group.new('TSNote', c.roleAccent) -- Text representation of an informational note.
  Group.new('TSWarning', c.roleAttention) -- Text representation of a warning note.
  Group.new('TSDanger', c.roleDanger) -- Text representation of a danger note.
  Group.new('TSType', c.syntaxType) -- Type (and class) definitions and annotations.
  Group.new('TSTypeBuiltin', c.syntaxKeyword, nil, s.italic) -- Built-in types: `i32` in Rust.
  Group.new('TSVariable', c.syntaxVariable) -- Variable names that don't fit into other categories.
  Group.new('TSVariableBuiltin', c.syntaxVariable) -- Variable names defined by the language: `this` or `self` in Javascript.

  -- Lua
  Group.new('luaTSConstructor', c.fg)

  -- akinsho/bufferline.nvim
  Group.new('BufferLineFill', nil, c.pmenuBg)
  Group.new('BufferLineBufferInactive', nil, c.activeLineBg)
  Group.new('BufferLineBufferSelected', c.fg, c.canvas)
  Group.new('BufferLineBufferVisible', nil, c.canvas)

  -- lukas-reineke/indent-blankline.nvim
  Group.new('IndentGuide', c.whitespace)
  Group.link('IndentBlanklineChar', g.IndentGuide)
  Group.link('IndentBlanklineSpaceChar', g.IndentGuide)
  Group.link('IndentBlanklineSpaceCharBlankline', g.IndentGuide)
  Group.new('IndentBlanklineContextChar', c.roleAccent)

  -- WhichKey
  Group.new('WhichKey', c.syntaxConstant) -- the key
  Group.new('WhichKeyGroup', c.syntaxKeyword) -- a group
  Group.new('WhichKeySeparator', c.syntaxComment) -- the separator between the key and its label
  Group.new('WhichKeyDesc', c.fg) -- the label of the key
  Group.new('WhichKeyFloat', nil, c.pmenuBg) -- Normal in the popup window
  Group.new('WhichKeyValue', c.syntaxComment) -- used by plugins that provide values

  -- Telescope
  Group.new('TelescopeNormal', c.fg, c.canvas)
  Group.new('TelescopeBorder', c.roleNeutral, c.canvas)
  Group.new('TelescopePromptBorder', c.roleAccent, c.canvas)
  Group.new('TelescopeSelection', c.fgOnEmphasis, c.pmenuBg, s.bold)
  Group.new('TelescopePromptPrefix', c.roleDanger)
  Group.new('TelescopeSelectionCaret', c.roleSuccess, c.pmenuBg)
  Group.new('TelescopeMatching', c.roleAccent, nil, s.bold)
  Group.new('TelescopePreviewNormal', c.fg, c.canvas)

  -- diff
  Group.new('diffAdded', c.fg, c.diffAddLineBg)
  Group.new('diffRemoved', c.fg, c.diffDeleteLineBg)
  Group.new('diffChanged', c.fg, c.diffChangeLineBg)
  Group.new('diffOldFile', c.yellow)
  Group.new('diffNewFile', c.orange)
  Group.new('diffFile', c.roleAccent)
  Group.new('diffLine', c.roleNeutral)
  Group.new('diffIndexLine', c.magenta)

  -- Neogit
  Group.new('NeogitBranch', c.syntaxKeyword)
  Group.new('NeogitRemote', c.syntaxKeyword)
  Group.new('NeogitHunkHeader', c.fg, c.activeLineBg)
  Group.new('NeogitHunkHeaderHighlight', c.roleAccent, c.activeLineBg, s.italic)
  Group.new('NeogitDiffContextHighlight', c.fg, c.canvas)
  Group.new('NeogitDiffDeleteHighlight', c.fg, c.diffDeleteLineBg)
  Group.new('NeogitDiffAddHighlight', c.fg, c.diffAddLineBg)

  -- GitGutter
  Group.new('GitGutterAdd', c.diffAddSign) -- diff mode: Added line |diff.txt|
  Group.new('GitGutterChange', c.diffChangeSign) -- diff mode: Changed line |diff.txt|
  Group.new('GitGutterDelete', c.diffDeleteSign) -- diff mode: Deleted line |diff.txt|

  -- GitSigns
  Group.new('GitSignsAdd', c.diffAddSign) -- diff mode: Added line |diff.txt|
  Group.new('GitSignsChange', c.diffChangeSign) -- diff mode: Changed line |diff.txt|
  Group.new('GitSignsDelete', c.diffDeleteSign) -- diff mode: Deleted line |diff.txt|

  -- DevIcons
  Color.new('devIconC', '#519aba')
  Color.new('devIconClojure', '#8dc149')
  Color.new('devIconCoffeescript', '#cbcb41')
  Color.new('devIconCsharp', '#519aba')
  Color.new('devIconCss', '#519aba')
  Color.new('devIconMarkdown', '#519aba')
  Color.new('devIconGo', '#519aba')
  Color.new('devIconHtml', '#e37933')
  Color.new('devIconJava', '#cc3e44')
  Color.new('devIconJavascript', '#cbcb41')
  Color.new('devIconJson', '#cbcb41')
  Color.new('devIconLess', '#519aba')
  Color.new('devIconMake', '#e37933')
  Color.new('devIconMustache', '#e37933')
  Color.new('devIconPhp', '#a074c4')
  Color.new('devIconPython', '#4e93b3')
  Color.new('devIconRubyOnRails', '#cc3e44')
  Color.new('devIconRuby', '#cc3e44')
  Color.new('devIconSass', '#f55385')
  Color.new('devIconScss', '#f55385')
  Color.new('devIconShellscript', '#4d5a5e')
  Color.new('devIconSql', '#f55385')
  Color.new('devIconTypescript', '#519aba')
  Color.new('devIconXml', '#e37933')
  Color.new('devIconYml', '#a074c4')

  Group.new('DevIconC', c.devIconC)
  Group.new('DevIconClojure', c.devIconClojure)
  Group.new('DevIconCoffee', c.devIconCoffeescript)
  Group.new('DevIconCs', c.devIconCsharp)
  Group.new('DevIconCss', c.devIconCss)
  Group.new('DevIconMarkdown', c.devIconMarkdown)
  Group.new('DevIconGo', c.devIconGo)
  Group.new('DevIconHtm', c.devIconHtml)
  Group.new('DevIconHtml', c.devIconHtml)
  Group.new('DevIconJava', c.devIconJava)
  Group.new('DevIconJs', c.devIconJavascript)
  Group.new('DevIconJson', c.devIconJson)
  Group.new('DevIconLess', c.devIconLess)
  Group.new('DevIconMakefile', c.devIconMake)
  Group.new('DevIconMustache', c.devIconMustache)
  Group.new('DevIconPhp', c.devIconPhp)
  Group.new('DevIconPython', c.devIconPython)
  Group.new('DevIconErb', c.devIconRubyOnRails)
  Group.new('DevIconRb', c.devIconRuby)
  Group.new('DevIconSass', c.devIconSass)
  Group.new('DevIconScss', c.devIconScss)
  Group.new('DevIconSh', c.devIconShellscript)
  Group.new('DevIconSql', c.devIconSql)
  Group.new('DevIconTs', c.devIconTypescript)
  Group.new('DevIconXml', c.devIconXml)
  Group.new('DevIconYaml', c.devIconYml)
  Group.new('DevIconYml', c.devIconYml)

  -- Compe
  Group.link('CompeDocumentation', g.NormalFloat)
  Group.link('CompeDocumentationBorder', g.FloatBorder)

  -- Cmp
  Group.link('CmpDocumentation', g.NormalFloat)
  Group.link('CmpDocumentationBorder', g.FloatBorder)
end
