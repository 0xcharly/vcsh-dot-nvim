local M = {}

M.palette = {
  mono_1 = '#abb2bf',
  mono_2 = '#828997',
  mono_3 = '#5c6370',
  mono_4 = '#4b5263',

  hue_1 = '#56b6c2',
  hue_2 = '#61afef',
  hue_3 = '#c678dd',
  hue_4 = '#98c379',

  hue_5 = '#e06c75',
  hue_5_2 = '#be5046',

  hue_6 = '#d19a66',
  hue_6_2 = '#e5c07b',

  syntax_bg = '#282c34',
  syntax_gutter = '#636d83',
  syntax_cursor = '#2c323c',

  syntax_accent = '#528bff',

  vertsplit = '#181a1f',
  special_grey = '#3b4048',
  visual_grey = '#3e4452',
  pmenu = '#333841',
}

M.theme = {
  fg = M.palette.mono_1,
  bg = M.palette.syntax_bg,
  menu_fg = M.palette.mono_2,
  menu_bg = M.palette.pmenu,
  accent = M.palette.syntax_accent,
  on_surface = M.palette.syntax_cursor,
  cyan = M.palette.hue_1,
  blue = M.palette.hue_2,
  magenta = M.palette.hue_3,
  green = M.palette.hue_4,
  red = M.palette.hue_5,
  yellow = M.palette.hue_6,
}

M.vi_mode = {
  normal = M.theme.green,
  insert = M.theme.yellow,
  replace = M.theme.red,
  visual = M.theme.blue,
  command = M.theme.magenta,
  terminal = M.theme.cyan,
}

M.brand = {git = '#e84e31'}

return M
