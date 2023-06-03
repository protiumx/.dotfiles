local colors = {
  background = '#1c1c1c',
  foreground = '#cacaca',
  accent = '#fe5186',
  blue = '#61afef',
  cyan = '#3e8fb0',
  dark_green = '#5faf5f',
  dark_grey = '#222222',
  dark_orange = '#ff5d62',
  dark_red = '#bf1131',
  dark_yellow = '#ffaf00',
  green = '#98c379',
  grey = '#2a2a2a',
  light_grey = '#727169',
  light_orange = '#ffa066',
  light_pink = '#e46876',
  light_yellow = '#e6db74',
  magenta = '#c678dd',
  orange = '#ff8700',
  purple = '#af87d7',
  red = '#c4384b',
  violet = '#a9a1e1',
  white = '#e3e3e3',
  yellow = '#d7af5f',
}

colors.accent = colors.dark_orange

-- Overrides for all color schemes
local groups = {
  -- Custom for floats and borders
  XMenu                   = { bg = colors.dark_grey, default = true },
  XBorder                 = { bg = colors.dark_grey, fg = colors.dark_grey, default = true },
  -- Base groups
  ColorColumn             = { bg = colors.grey },
  CursorLine              = { bg = nil, fg = nil },
  CursorLineNr            = { bg = nil },
  EndOfBuffer             = { fg = colors.background },
  ErrorMsg                = { fg = colors.red, bg = nil, bold = true },
  FloatBorder             = { link = 'XBorder' },
  FloatNormal             = { link = 'XMenu' },
  MatchParen              = { fg = colors.accent, bg = nil, bold = true },
  NormalFloat             = { link = 'XMenu' },
  -- NonText                    = { fg = colors.light_grey },
  Pmenu                   = { link = 'XMenu' },
  SignColumn              = { bg = nil },
  StatusLine              = { bg = colors.background, fg = colors.foreground },
  Todo                    = { fg = colors.orange, bold = true },
  Visual                  = { bg = colors.grey, fg = nil },
  -- Mason
  MasonHeader             = { link = 'XMenu' },
  MasonNormal             = { link = 'XMenu' },
  -- Telescope
  TelescopeBorder         = { link = 'XBorder' },
  TelescopeNormal         = { bg = colors.background },
  TelescopePreviewBorder  = { link = 'XBorder' },
  TelescopePreviewLine    = { fg = colors.background, bg = colors.orange },
  TelescopePreviewNormal  = { link = 'XMenu', fg = colors.foreground },
  TelescopePreviewTitle   = { fg = colors.background, bg = colors.light_orange },
  TelescopePromptBorder   = { link = 'XBorder' },
  TelescopePromptNormal   = { link = 'XMenu', fg = colors.foreground },
  TelescopePromptPrefix   = { link = 'XMenu', fg = colors.foreground },
  TelescopePromptTitle    = { fg = colors.background, bg = colors.light_orange },
  TelescopeResultsBorder  = { link = 'XBorder' },
  TelescopeResultsNormal  = { link = 'XMenu' },
  TelescopeResultsTitle   = { fg = colors.background, bg = colors.light_orange },
  -- lspsaga.nvim
  ActionPreviewBorder     = { link = 'XBorder' },
  ActionPreviewNormal     = { link = 'XMenu' },
  ActionPreviewTitle      = { link = 'XMenu' },
  CallHierarchyBorder     = { link = 'XBorder' },
  CallHierarchyNormal     = { link = 'XMenu' },
  DefinitionBorder        = { link = 'XBorder' },
  DefinitionNormal        = { link = 'XMenu' },
  DiagnosticBorder        = { link = 'XBorder' },
  DiagnosticNormal        = { link = 'XMenu' },
  DiagnosticShowNormal    = { link = 'XMenu' },
  DiagnosticShowBorder    = { link = 'XBorder' },
  FinderBorder            = { link = 'XBorder' },
  FinderNormal            = { link = 'XMenu' },
  HoverBorder             = { link = 'XBorder' },
  HoverNormal             = { link = 'XMenu' },
  OutlinePreviewBorder    = { link = 'XBorder' },
  OutlinePreviewNormal    = { link = 'XMenu' },
  RenameBorder            = { link = 'XBorder' },
  RenameNormal            = { link = 'XMenu' },
  SagaBorder              = { link = 'XBorder' },
  SagaNormal              = { link = 'XMenu' },
  TerminalBorder          = { link = 'XBorder' },
  TerminalNormal          = { link = 'XMenu' },
  SagaShadow              = { fg = colors.background, bg = colors.background },
  TitleIcon               = { fg = colors.foreground, bg = colors.light_orange },
  TitleString             = { fg = colors.background, bg = colors.light_orange },
  -- Neotree
  NeoTreeCursorLine       = { bg = colors.dark_grey, fg = colors.accent },
  NeoTreeFloatBorder      = { link = 'XBorder' },
  NeoTreeFloatTitle       = { fg = colors.background, bg = colors.light_orange },
  NeoTreeTitleBar         = { fg = colors.background, bg = colors.light_orange },
  -- Noice.nvim
  NoiceCmdlineIcon        = { fg = colors.dark_orange },
  NoiceCmdlinePopupBorder = { link = 'XBorder' },
}


local function _load(config)
  for group, hl in pairs(config) do
    if not vim.tbl_isempty(hl) then
      vim.api.nvim_set_hl(0, group, hl)
    end
  end
end

local function _load_diagnostics()
  local diagnostics = {
    DiagnosticSignError = vim.tbl_extend('force', vim.api.nvim_get_hl_by_name('DiagnosticSignError', true),
      { bg = nil }),
    DiagnosticSignWarn  = vim.tbl_extend('force', vim.api.nvim_get_hl_by_name('DiagnosticSignWarn', true),
      { bg = nil }),
    DiagnosticSignInfo  = vim.tbl_extend('force', vim.api.nvim_get_hl_by_name('DiagnosticSignInfo', true),
      { bg = nil }),
    DiagnosticSignHint  = vim.tbl_extend('force', vim.api.nvim_get_hl_by_name('DiagnosticSignHint', true),
      { bg = nil }),
  }
  _load(diagnostics)
end

function colors.load()
  _load(groups)
  vim.g.terminal_color_0 = colors.background
end

return colors
