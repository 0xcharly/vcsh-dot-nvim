-- From https://github.com/primer/primitives.
local githubDarkScale = {
  black = '#010409',
  white = '#f0f6fc',
  gray = {
    shade0 = '#f0f6fc',
    shade1 = '#c9d1d9',
    shade2 = '#b1bac4',
    shade3 = '#8b949e',
    shade4 = '#6e7681',
    shade5 = '#484f58',
    shade6 = '#30363d',
    shade7 = '#21262d',
    shade8 = '#161b22',
    shade9 = '#0d1117',
  },
  blue = {
    shade0 = '#cae8ff',
    shade1 = '#a5d6ff',
    shade2 = '#79c0ff',
    shade3 = '#58a6ff',
    shade4 = '#388bfd',
    shade5 = '#1f6feb',
    shade6 = '#1158c7',
    shade7 = '#0d419d',
    shade8 = '#0c2d6b',
    shade9 = '#051d4d',
  },
  green = {
    shade0 = '#aff5b4',
    shade1 = '#7ee787',
    shade2 = '#56d364',
    shade3 = '#3fb950',
    shade4 = '#2ea043',
    shade5 = '#238636',
    shade6 = '#196c2e',
    shade7 = '#0f5323',
    shade8 = '#033a16',
    shade9 = '#04260f',
  },
  yellow = {
    shade0 = '#f8e3a1',
    shade1 = '#f2cc60',
    shade2 = '#e3b341',
    shade3 = '#d29922',
    shade4 = '#bb8009',
    shade5 = '#9e6a03',
    shade6 = '#845306',
    shade7 = '#693e00',
    shade8 = '#4b2900',
    shade9 = '#341a00',
  },
  orange = {
    shade0 = '#ffdfb6',
    shade1 = '#ffc680',
    shade2 = '#ffa657',
    shade3 = '#f0883e',
    shade4 = '#db6d28',
    shade5 = '#bd561d',
    shade6 = '#9b4215',
    shade7 = '#762d0a',
    shade8 = '#5a1e02',
    shade9 = '#3d1300',
  },
  red = {
    shade0 = '#ffdcd7',
    shade1 = '#ffc1ba',
    shade2 = '#ffa198',
    shade3 = '#ff7b72',
    shade4 = '#f85149',
    shade5 = '#da3633',
    shade6 = '#b62324',
    shade7 = '#8e1519',
    shade8 = '#67060c',
    shade9 = '#490202',
  },
  purple = {
    shade0 = '#eddeff',
    shade1 = '#e2c5ff',
    shade2 = '#d2a8ff',
    shade3 = '#bc8cff',
    shade4 = '#a371f7',
    shade5 = '#8957e5',
    shade6 = '#6e40c9',
    shade7 = '#553098',
    shade8 = '#3c1e70',
    shade9 = '#271052',
  },
  pink = {
    shade0 = '#ffdaec',
    shade1 = '#ffbedd',
    shade2 = '#ff9bce',
    shade3 = '#f778ba',
    shade4 = '#db61a2',
    shade5 = '#bf4b8a',
    shade6 = '#9e3670',
    shade7 = '#7d2457',
    shade8 = '#5e103e',
    shade9 = '#42062a',
  },
  coral = {
    shade0 = '#FFDDD2',
    shade1 = '#FFC2B2',
    shade2 = '#FFA28B',
    shade3 = '#F78166',
    shade4 = '#EA6045',
    shade5 = '#CF462D',
    shade6 = '#AC3220',
    shade7 = '#872012',
    shade8 = '#640D04',
    shade9 = '#460701',
  },
}
local githubDimmedScale = {
  black = '#010409',
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
    shade8 = '#161b22',
    shade9 = '#0d1117',
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

local scale = githubDarkScale
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
