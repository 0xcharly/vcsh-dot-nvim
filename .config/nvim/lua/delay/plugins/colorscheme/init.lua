-- From https://github.com/primer/primitives.
local githubDimmedScale = {
  black = '#1c2128',
  white = '#cdd9e5',
  gray = {
    shade0 = '#cdd9e5',
    shade1 = '#adbac7',
    shade2 = '#909dab',
    shade3 = '#768390',
    shade4 = '#636e7b',
    shade5 = '#545d68',
    shade6 = '#444c56',
    shade7 = '#373e47',
    shade8 = '#2d333b',
    shade9 = '#22272e',
  },
  blue = {
    shade0 = '#c6e6ff',
    shade1 = '#96d0ff',
    shade2 = '#6cb6ff',
    shade3 = '#539bf5',
    shade4 = '#4184e4',
    shade5 = '#316dca',
    shade6 = '#255ab2',
    shade7 = '#1b4b91',
    shade8 = '#143d79',
    shade9 = '#0f2d5c',
  },
  green = {
    shade0 = '#b4f1b4',
    shade1 = '#8ddb8c',
    shade2 = '#6bc46d',
    shade3 = '#57ab5a',
    shade4 = '#46954a',
    shade5 = '#347d39',
    shade6 = '#2b6a30',
    shade7 = '#245829',
    shade8 = '#1b4721',
    shade9 = '#113417',
  },
  yellow = {
    shade0 = '#fbe090',
    shade1 = '#eac55f',
    shade2 = '#daaa3f',
    shade3 = '#c69026',
    shade4 = '#ae7c14',
    shade5 = '#966600',
    shade6 = '#805400',
    shade7 = '#6c4400',
    shade8 = '#593600',
    shade9 = '#452700',
  },
  orange = {
    shade0 = '#ffddb0',
    shade1 = '#ffbc6f',
    shade2 = '#f69d50',
    shade3 = '#e0823d',
    shade4 = '#cc6b2c',
    shade5 = '#ae5622',
    shade6 = '#94471b',
    shade7 = '#7f3913',
    shade8 = '#682d0f',
    shade9 = '#4d210c',
  },
  red = {
    shade0 = '#ffd8d3',
    shade1 = '#ffb8b0',
    shade2 = '#ff938a',
    shade3 = '#f47067',
    shade4 = '#e5534b',
    shade5 = '#c93c37',
    shade6 = '#ad2e2c',
    shade7 = '#922323',
    shade8 = '#78191b',
    shade9 = '#5d0f12',
  },
  purple = {
    shade0 = '#eedcff',
    shade1 = '#dcbdfb',
    shade2 = '#dcbdfb',
    shade3 = '#b083f0',
    shade4 = '#986ee2',
    shade5 = '#8256d0',
    shade6 = '#6b44bc',
    shade7 = '#5936a2',
    shade8 = '#472c82',
    shade9 = '#352160',
  },
  pink = {
    shade0 = '#ffd7eb',
    shade1 = '#ffb3d8',
    shade2 = '#fc8dc7',
    shade3 = '#e275ad',
    shade4 = '#c96198',
    shade5 = '#ae4c82',
    shade6 = '#983b6e',
    shade7 = '#7e325a',
    shade8 = '#69264a',
    shade9 = '#551639',
  },
  coral = {
    shade0 = '#ffdacf',
    shade1 = '#ffb9a5',
    shade2 = '#f79981',
    shade3 = '#ec775c',
    shade4 = '#de5b41',
    shade5 = '#c2442d',
    shade6 = '#a93524',
    shade7 = '#8d291b',
    shade8 = '#771d13',
    shade9 = '#5d1008',
  },
}

local scale = githubDimmedScale
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
