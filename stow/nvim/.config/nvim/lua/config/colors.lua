local colors = {
  background = '#161616',
  foreground = '#fbf1c7',
  accent = '#fe5186',
  blue = '#61afef',
  cyan = '#3e8fb0',
  dark_green = '#5faf5f',
  dark_grey = '#1a1a1a',
  dark_orange = '#ff5d62',
  dark_red = '#bf1131',
  dark_yellow = '#ffaf00',
  green = '#98c379',
  grey = '#202020',
  light_grey = '#727169',
  light_orange = '#ffa066',
  light_pink = '#e46876',
  light_yellow = '#e6db74',
  magenta = '#c678dd',
  orange = '#ff8700',
  purple = '#af87d7',
  red = '#fb4934',
  violet = '#a9a1e1',
  white = '#e3e3e3',
  yellow = '#d7af5f',
}

colors.accent = colors.red

-- Overrides for all color schemes
local baseHls = {
  -- Custom for floats and borders
  XMenu                   = { bg = colors.dark_grey, default = true, fg = colors.foreground },
  XBorder                 = { bg = colors.dark_grey, fg = colors.dark_grey, default = true },
  -- Base groups
  Normal                  = { bg = colors.background },
  NormalNC                = { bg = colors.background },
  Cursor                  = { fg = colors.background, bg = colors.accent },
  TermCursor              = { link = 'Cursor' },
  ColorColumn             = { bg = colors.dark_grey },
  -- CursorLine              = { bg = 'none', fg = 'none' },
  -- CursorLineNr            = { bg = 'none' },
  -- LineNr                  = { bg = 'none' },
  EndOfBuffer             = { fg = colors.background },
  ErrorMsg                = { fg = colors.red, bg = 'none', bold = true },
  FloatBorder             = { link = 'XBorder' },
  FloatNormal             = { link = 'XMenu' },
  MatchParen              = { fg = colors.background, bg = colors.violet },
  NormalFloat             = { link = 'XMenu' },
  -- NonText                    = { fg = colors.light_grey },
  Pmenu                   = { link = 'XMenu' },
  SignColumn              = { bg = 'none' },
  StatusLine              = { bg = colors.background, fg = colors.foreground },
  Todo                    = { fg = colors.orange, bold = true },
  Visual                  = { bg = colors.grey, fg = nil },
  -- Mason
  MasonHeader             = { link = 'XMenu' },
  MasonNormal             = { link = 'XMenu' },
  -- Telescope
  TelescopeBorder         = { link = 'XBorder' },
  TelescopeNormal         = { bg = colors.background, fg = colors.foreground },
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
  -- LSP
  LspReferenceText        = { bg = colors.red, fg = colors.foreground },
  -- Neotree
  NeoTreeCursorLine       = { bg = colors.dark_grey, fg = colors.accent },
  NeoTreeFloatBorder      = { link = 'XBorder' },
  NeoTreeFloatTitle       = { fg = colors.background, bg = colors.light_orange },
  NeoTreeTitleBar         = { fg = colors.background, bg = colors.light_orange },
  NeoTreeNormal           = { bg = colors.background },
  -- Noice.nvim
  NoiceCmdlineIcon        = { fg = colors.red },
  NoiceCmdlineIconInput   = { fg = colors.red },
  NoiceCmdlineIconSearch  = { fg = colors.red },
  NoiceCmdlinePopup       = { link = 'XMenu' },
  NoiceCmdlinePopupBorder = { link = 'XBorder' },
  NoiceConfirm            = { link = 'XMenu' },
  NoiceConfirmBorder      = { link = 'XBorder' },
  NoicePopup              = { link = 'XMenu' },
  NoicePopupBorder        = { link = 'XBorder' },
  NoicePopupmenu          = { link = 'XMenu' },
  NoicePopupmenuBorder    = { link = 'XBorder' },
  -- notify.nvim
  NotifyERRORBorder       = { fg = colors.background },
  NotifyWARNBorder        = { fg = colors.background },
  NotifyINFOBorder        = { fg = colors.background },
  NotifyDEBUGBorder       = { fg = colors.background },
  NotifyTRACEBorder       = { fg = colors.background },
  -- web-dev-icons
  -- DevIconDefault          = { fg = colors.dark_orange, bg = 'none' },
}

local diagnosticsHls = {
  DiagnosticVirtualTextError = vim.tbl_extend('force',
    vim.api.nvim_get_hl_by_name('DiagnosticVirtualTextError', true) or {},
    { bg = 'none' }),
  DiagnosticVirtualTextWarn  = vim.tbl_extend('force',
    vim.api.nvim_get_hl_by_name('DiagnosticVirtualTextWarn', true) or {},
    { bg = 'none' }),
  DiagnosticVirtualTextInfo  = vim.tbl_extend('force',
    vim.api.nvim_get_hl_by_name('DiagnosticVirtualTextInfo', true) or {},
    { bg = 'none' }),
  DiagnosticVirtualTextHint  = vim.tbl_extend('force',
    vim.api.nvim_get_hl_by_name('DiagnosticVirtualTextHint', true) or {},
    { bg = 'none' }),
  DiagnosticSignError        = vim.tbl_extend('force',
    vim.api.nvim_get_hl_by_name('DiagnosticSignError', true) or {},
    { bg = 'none' }),
  DiagnosticSignWarn         = vim.tbl_extend('force',
    vim.api.nvim_get_hl_by_name('DiagnosticSignWarn', true) or {},
    { bg = 'none' }),
  DiagnosticSignInfo         = vim.tbl_extend('force',
    vim.api.nvim_get_hl_by_name('DiagnosticSignInfo', true) or {},
    { bg = 'none' }),
  DiagnosticSignHint         = vim.tbl_extend('force',
    vim.api.nvim_get_hl_by_name('DiagnosticSignHint', true) or {},
    { bg = 'none' }),
}

local function load(gs)
  for group, hl in pairs(gs) do
    vim.api.nvim_set_hl(0, group, hl)
  end
end

function colors.load()
  load(baseHls)
  load(diagnosticsHls)

  vim.g.terminal_color_0 = colors.background
end

return colors
