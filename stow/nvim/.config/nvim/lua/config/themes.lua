local colors = require('config.colors')

local theme = {
  -- VIM
  Special = { fg = colors.dark_yellow },

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
  ['@string'] = { fg = colors.yellow, bg = '' },
  ['@string.escape'] = { fg = colors.dark_orange, bold = true, bg = '' },
  ['@string.special'] = { fg = colors.dark_orange, bold = true },
  ['@character'] = { fg = colors.foreground, bg = '' },
  ['@character.special'] = { fg = colors.dark_orange, bold = true, bg = '' },
  ['@number'] = { fg = colors.light_pink, bg = '' },
  ['@boolean'] = { fg = colors.dark_yellow, bold = true, bg = '' },
  ['@float'] = { fg = colors.light_pink, bg = '' },

  ['@function'] = { fg = colors.foreground, bg = '' },
  ['@function.builtin'] = { fg = colors.blue, bg = '' },
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
