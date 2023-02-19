local colors = require('config.colors')

local theme = {
  -- VIM
  Special = { fg = colors.accent },

  -- Transparent background

  Conceal = { bg = 'none', fg = colors.foreground },
  LineNr = { bg = 'none', fg = colors.grey },
  MsgArea = { bg = 'none', fg = colors.foreground },
  NonText = { bg = 'none', fg = colors.foreground },
  Normal = { bg = 'none', fg = colors.foreground },
  NormalNC = { bg = 'none', fg = colors.foreground },
  SignColumn = { bg = 'none' },
  TelescopeBorder = { bg = 'none', ctermbg = 'none' },
  WinSeparator = { bg = 'none', ctermbg = 'none' },

  ------

  ColorColumn = { bg = colors.dark_grey },
  Cursor = { bg = colors.accent },
  CursorColumn = { bg = 'none', fg = colors.accent },
  CursorLine = { bg = 'none', fg = 'none' },
  ErrorMsg = { bg = 'none', fg = '#bf1131' },
  FloatBorder = { bg = 'none' },
  IncSearch = { bg = colors.accent, fg = colors.foreground },
  MatchParen = { fg = colors.accent, bg = 'none' },
  NormalFloat = { bg = 'none' },
  Search = { bg = colors.accent },
  SpellBad = { bg = 'none', fg = 'none', undercurl = true, ctermbg = 'none', ctermfg = 'none' },
  SpellLocal = { bg = 'none', fg = 'none', undercurl = true, ctermbg = 'none', ctermfg = 'none' },
  SpellRare = { bg = 'none', fg = 'none', undercurl = true, ctermbg = 'none', ctermfg = 'none' },
  StatusLine = { fg = colors.white, bg = colors.background },
  Todo = { fg = '#ff8700', bold = true, bg = 'none', ctermbg = 'none' },
  VertSplit = { bg = 'none', fg = colors.grey },

  -- Diagnostic

  DiagnosticError = { fg = colors.red },
  DiagnosticFloatingError = { bg = 'none', fg = colors.red },
  DiagnosticFloatingHint = { bg = 'none' },
  DiagnosticFloatingInfo = { bg = 'none' },
  DiagnosticFloatingWarn = { bg = 'none', fg = colors.yellow },
  DiagnosticSignHint = { fg = colors.grey, bold = true },
  DiagnosticUnderlineError = { undercurl = true },
  DiagnosticVirtualTextHint = { bg = 'none' },
  DiagnosticWarn = { fg = colors.yellow },


  -- Treesitter

  ['@text.literal'] = { fg = colors.yellow, bg = '' },
  -- ['@text.reference'] = { fg = '', bg = '' },
  ['@text.title'] = { fg = colors.blue, bg = '' },
  -- ['@text.uri'] = { fg = '', bg = '' },
  -- ['@text.underline'] = { fg = '', bg = '' },
  ['@text.todo'] = { fg = colors.orange, bg = '' },
  ['@text.strong'] = { bold = true },
  ['@text.warning'] = { fg = colors.orange },
  ['@text.danger'] = { fg = colors.dark_orange },

  ['@comment'] = { fg = colors.light_grey, bg = '' },
  ['@punctuation.Special'] = { fg = colors.purple, bg = '' },
  ['@punctuation.bracket'] = { fg = colors.purple, bg = '' },
  ['@punctuation.delimiter'] = { fg = colors.purple, bg = '' },

  ['@constant'] = { fg = colors.foreground, bg = '' },
  ['@constant.builtin'] = { fg = colors.dark_yellow, bg = '' },
  ['@constant.macro'] = { fg = colors.dark_orange, bg = '' },
  -- ['@define'] = { fg = '', bg = '' },
  ['@macro'] = { fg = colors.dark_orange, bg = '' },
  -- ['@string'] = { fg = colors.yellow, bg = '' },
  ['@string.escape'] = { fg = colors.dark_orange, bg = '' },
  ['@string.special'] = { fg = colors.dark_orange },
  ['@string.regex'] = { fg = colors.green },
  ['@character'] = { fg = colors.foreground, bg = '' },
  ['@character.special'] = { fg = colors.dark_orange, bold = true, bg = '' },
  ['@number'] = { fg = colors.light_pink, bg = '' },
  ['@boolean'] = { fg = colors.dark_yellow, bold = true, bg = '' },
  ['@float'] = { fg = colors.light_pink, bg = '' },

  ['@function'] = { fg = colors.foreground, bg = '' },
  ['@function.builtin'] = { fg = colors.green, bg = '' },
  ['@function.macro'] = { fg = colors.dark_orange, bg = '' },
  ['@parameter'] = { fg = colors.foreground, bg = '' },
  ['@method'] = { fg = colors.foreground, bg = '' },
  ['@field'] = { fg = colors.foreground, bg = '' },
  ['@property'] = { fg = colors.foreground, bg = '' },
  ['@constructor'] = { fg = colors.blue, bg = '' },

  ['@conditional'] = { fg = colors.blue, bg = '' },
  ['@repeat'] = { fg = colors.blue, bg = '' },
  ['@label'] = { fg = colors.blue, bg = '' },
  ['@operator'] = { fg = colors.purple, bg = '' },
  ['@keyword'] = { fg = colors.blue, bg = '' },
  ['@keyword.return'] = { fg = colors.dark_orange },
  ['@exception'] = { fg = colors.dark_orange, bg = '' },

  ['@variable'] = { fg = colors.foreground, bg = '' },
  ['@variable.builtin'] = { fg = colors.light_orange, bg = '' },
  ['@type'] = { fg = colors.light_orange, bg = '' },
  ['@type.definition'] = { fg = colors.foreground, bg = '' },
  -- ['@storageclass'] = { fg = '', bg = '' },
  -- ['@structure'] = { fg = '', bg = '' },
  ['@namespace'] = { fg = colors.foreground, bg = '' },
  ['@include'] = { fg = colors.dark_orange, bg = '' },
  -- ['@preproc'] = { fg = '', bg = '' },
  -- ['@debug'] = { fg = '', bg = '' },
  ['@tag'] = { fg = colors.orange, bg = '' },
  ['@tag.delimiter'] = { fg = colors.purple },
  ['@tag.attribute'] = { fg = colors.foreground },
}

local M = {}

function M.load()
  for group, colors in pairs(theme) do
    if not vim.tbl_isempty(colors) then
      vim.api.nvim_set_hl(0, group, colors)
    end
  end
end

return M
