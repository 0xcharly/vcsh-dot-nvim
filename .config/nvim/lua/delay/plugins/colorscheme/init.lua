-- From https://github.com/primer/primitives.
local scale = require('delay.plugins.colorscheme.github_dark_dimmed')
local theme = {
  ansi = {
    black = scale.gray.shade9,
    blackBright = scale.gray.shade8,
    white = scale.gray.shade2,
    whiteBright = scale.gray.shade2,
    gray = scale.gray.shade4,
    red = scale.red.shade3,
    redBright = scale.red.shade2,
    green = scale.green.shade3,
    greenBright = scale.green.shade2,
    yellow = scale.yellow.shade3,
    yellowBright = scale.yellow.shade2,
    blue = scale.blue.shade3,
    blueBright = scale.blue.shade2,
    magenta = scale.purple.shade3,
    magentaBright = scale.purple.shade2,
    cyan = '#76e3ea',
    cyanBright = '#b3f0ff',
  },
  fg = {
    default = scale.gray.shade1,
    muted = scale.gray.shade3,
    subtle = scale.gray.shade5,
    onEmphasis = scale.white,
  },
  canvas = {
    default = scale.gray.shade9,
    overlay = scale.gray.shade8,
    inset = scale.black,
    subtle = scale.gray.shade8,
  },
}

local util = {}

local function hexToRgb(hex_str)
  local hex = '[abcdef0-9][abcdef0-9]'
  local pat = '^#(' .. hex .. ')(' .. hex .. ')(' .. hex .. ')$'
  hex_str = string.lower(hex_str)

  assert(string.find(hex_str, pat) ~= nil,
         'hex_to_rgb: invalid hex_str: ' .. tostring(hex_str))

  local r, g, b = string.match(hex_str, pat)
  return {tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)}
end

---@param fg string foreground color
---@param bg string background color
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
util.blend = function(fg, bg, alpha)
  fg = hexToRgb(fg)
  bg = hexToRgb(bg)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format('#%02X%02X%02X', blendChannel(1), blendChannel(2),
                       blendChannel(3))
end

util.alpha = function(hex, amount)
  return util.blend(hex, theme.canvas.default, math.abs(amount))
end

for key, value in pairs({
  border = {
    default = scale.gray.shade6,
    muted = scale.gray.shade7,
    subtle = util.alpha(scale.gray.shade0, 0.1),
  },

  -- Roles
  neutral = {
    emphasis = scale.gray.shade2,
    onOverlay = scale.gray.shade1,
    emphasisPlus = scale.gray.shade4,
    muted = util.alpha(scale.gray.shade4, 0.4),
    subtle = util.alpha(scale.gray.shade4, 0.1),
  },
  accent = {
    onCanvas = scale.blue.shade3,
    onOverlay = scale.blue.shade2,
    emphasis = scale.blue.shade5,
    muted = util.alpha(scale.blue.shade4, 0.4),
    subtle = util.alpha(scale.blue.shade4, 0.15),
  },
  success = {
    onCanvas = scale.green.shade3,
    onOverlay = scale.green.shade2,
    emphasis = scale.green.shade5,
    muted = util.alpha(scale.green.shade4, 0.4),
    subtle = util.alpha(scale.green.shade4, 0.15),
  },
  attention = {
    onCanvas = scale.yellow.shade3,
    onOverlay = scale.yellow.shade2,
    emphasis = scale.yellow.shade5,
    muted = util.alpha(scale.yellow.shade4, 0.4),
    subtle = util.alpha(scale.yellow.shade4, 0.15),
  },
  severe = {
    onCanvas = scale.orange.shade4,
    onOverlay = scale.orange.shade3,
    emphasis = scale.orange.shade5,
    muted = util.alpha(scale.orange.shade4, 0.4),
    subtle = util.alpha(scale.orange.shade4, 0.15),
  },
  danger = {
    onCanvas = scale.red.shade4,
    onOverlay = scale.red.shade3,
    emphasis = scale.red.shade5,
    muted = util.alpha(scale.red.shade4, 0.4),
    subtle = util.alpha(scale.red.shade4, 0.15),
  },
  done = {
    onCanvas = scale.purple.shade4,
    onOverlay = scale.purple.shade3,
    emphasis = scale.purple.shade5,
    muted = util.alpha(scale.purple.shade4, 0.4),
    subtle = util.alpha(scale.purple.shade4, 0.15),
  },
}) do theme[key] = value end

for key, value in pairs({
  diffBlob = {
    addition = {
      fg = theme.fg.default,
      lineBg = theme.success.subtle,
      numBg = util.alpha(scale.green.shade3, 0.3),
      numText = theme.fg.default,
      wordBg = theme.success.muted,
    },
    modification = {
      fg = theme.fg.default,
      lineBg = theme.attention.subtle,
      numBg = util.alpha(scale.yellow.shade3, 0.3),
      numText = theme.fg.default,
      wordBg = theme.attention.muted,
    },
    deletion = {
      fg = theme.fg.default,
      lineBg = theme.danger.subtle,
      numBg = util.alpha(scale.red.shade4, 0.3),
      numText = theme.fg.default,
      wordBg = theme.danger.muted,
    },
    hunk = {numBg = theme.accent.muted},
    expander = {icon = theme.fg.muted},
  },
  diffstat = {
    addition = {fg = theme.success.onCanvas, border = theme.border.subtle},
    modification = {fg = theme.attention.onCanvas, border = theme.border.subtle},
    deletion = {fg = theme.danger.onCanvas, border = theme.border.subtle},
  },
  searchKeyword = {hl = util.alpha(scale.yellow.shade3, 0.4)},
}) do theme[key] = value end

return {scale = scale, theme = theme, util = util}
