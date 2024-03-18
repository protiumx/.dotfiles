local colors = {
  background = '#0a0a00',
  foreground = '#fbf1c7',
  accent = '#fe5186',
  blue = '#61afef',
  cyan = '#3e8fb0',
  dark_green = '#5faf5f',
  dark_grey = '#161616',
  dark_orange = '#ff5d62',
  dark_red = '#bf1131',
  dark_yellow = '#ffaf00',
  dark_violet = '#605060',
  green = '#98c379',
  grey = '#202020',
  light_grey = '#727169',
  light_orange = '#ffa066',
  light_pink = '#e46876',
  light_yellow = '#e6db74',
  magenta = '#c678dd',
  orange = '#ff8700',
  dark_purple = '#21043c',
  purple = '#af87d7',
  red = '#fb4934',
  violet = '#a9a1e1',
  visual = '#262626',
  white = '#e3e3e3',
  yellow = '#d7af5f',
}

colors.accent = colors.red

-- Overrides for all color schemes
local base_groups = {
  -- Custom for floats and borders
  XMenu = { bg = colors.dark_grey, default = true, fg = colors.foreground },
  XBorder = { bg = colors.dark_grey, fg = colors.dark_grey, default = true },
  OnYank = { bg = colors.foreground, fg = colors.background, bold = true },

  DevOutputBufferTitle = { fg = colors.background, bg = colors.light_orange, bold = true },
  -- Base groups
  -- Normal = { bg = colors.background, fg = colors.foreground },
  -- NormalNC = { bg = colors.background, fg = colors.foreground },
  Normal = { fg = colors.foreground, bg = 'none' },
  NormalNC = { fg = colors.foreground, bg = 'none' },
  Cursor = { fg = colors.background, bg = colors.violet },
  TermCursor = { link = 'Cursor' },
  ColorColumn = { bg = '#1a1717' },
  CursorLine = { bg = 'none' },
  CursorLineNr = { fg = colors.orange, bg = 'none' },
  LineNr = { bg = 'none', fg = colors.dark_violet },
  EndOfBuffer = { fg = colors.background },
  ErrorMsg = { fg = colors.red, bg = 'none', bold = true },
  FloatBorder = { link = 'XBorder' },
  FloatNormal = { link = 'XMenu' },
  MatchParen = { fg = colors.violet, bold = true },
  NormalFloat = { link = 'XMenu' },
  NonText = { fg = '#303030' },
  Pmenu = { link = 'XMenu' },
  SignColumn = { bg = 'none' },
  StatusLine = { bg = colors.background, fg = colors.foreground },
  TabLineSel = { fg = '#b8bb26', bg = 'none' },
  -- Todo = { fg = colors.orange, bold = true },
  VertSplit = { fg = colors.grey },
  Visual = { bg = colors.violet, fg = colors.background },
  -- Gitsigns
  GitSignsCurrentLineBlame = { fg = colors.light_pink },

  -- Diffview
  DiffviewFilePanelCounter = { fg = colors.white },
  DiffviewFilePanelRootPath = { fg = colors.violet },
  DiffviewFilePanelSelected = { fg = colors.dark_orange, bold = true },
  DiffviewFilePanelTitle = { fg = colors.violet },
  DiffviewStatusAdded = { fg = colors.green, bg = 'none', bold = true },
  DiffviewStatusDeleted = { fg = colors.dark_red, bg = 'none', bold = true },
  DiffviewStatusUnmerged = { fg = colors.dark_yellow, bg = 'none', bold = true },
  DiffviewStatusUntracked = { fg = colors.green, bg = 'none', bold = true },
  DiffviewStatusRenamed = { fg = colors.violet, bg = 'none', bold = true },
  -- Mason
  MasonHeader = { link = 'XMenu' },
  MasonHeading = { link = 'XBorder' },
  MasonNormal = { link = 'XMenu' },
  -- Neogit
  NeogitHunkHeaderHighlight = { bg = 'none' },
  -- NeogitDiffContextHighlight = { link = '' },
  NeogitDiffAddHighlight = { link = 'DiffAdd' },
  NeogitDiffDeleteHighlight = { link = 'DiffDelete' },
  NeogitDiffHeaderHighlight = { link = 'DiffAdd' },
  NeogitFold = { fg = colors.dark_yellow },
  -- Telescope
  TelescopeBorder = { link = 'XBorder' },
  TelescopeNormal = { bg = colors.background, fg = colors.foreground },
  TelescopePreviewBorder = { link = 'XBorder' },
  TelescopePreviewLine = { fg = colors.background, bg = colors.orange },
  TelescopePreviewNormal = { link = 'XMenu', fg = colors.foreground },
  TelescopePreviewTitle = { fg = colors.background, bg = colors.light_orange },
  -- TelescopePrompt = { fg = colors.purple },
  TelescopePromptBorder = { link = 'XBorder' },
  TelescopePromptNormal = { link = 'XMenu', fg = colors.foreground },
  TelescopePromptPrefix = { link = 'XMenu', fg = colors.foreground },
  -- TelescopePromptTitle = { fg = colors.background, bg = colors.light_orange },
  TelescopeResultsBorder = { link = 'XBorder' },
  TelescopeResultsNormal = { link = 'XMenu' },
  -- TelescopeResultsTitle = { fg = colors.background, bg = colors.light_orange },
  -- TelescopeSelectionCaret = { fg = colors.red, bg = 'none' },
  -- TelescopeSelection = { fg = colors.orange, bg = 'none' },
  -- vim-sandwich
  OperatorSandwichBuns = { fg = colors.background, bg = colors.green },
  OperatorSandwichChange = { fg = colors.background, bg = colors.yellow },
  -- lspsaga.nvim
  ActionPreviewBorder = { link = 'XBorder' },
  ActionPreviewNormal = { link = 'XMenu' },
  ActionPreviewTitle = { link = 'XMenu' },
  CallHierarchyBorder = { link = 'XBorder' },
  CallHierarchyNormal = { link = 'XMenu' },
  DefinitionBorder = { link = 'XBorder' },
  DefinitionNormal = { link = 'XMenu' },
  DiagnosticBorder = { link = 'XBorder' },
  DiagnosticNormal = { link = 'XMenu' },
  DiagnosticShowNormal = { link = 'XMenu' },
  DiagnosticShowBorder = { link = 'XBorder' },
  FinderBorder = { link = 'XBorder' },
  FinderNormal = { link = 'XMenu' },
  HoverBorder = { link = 'XBorder' },
  HoverNormal = { link = 'XMenu' },
  OutlinePreviewBorder = { link = 'XBorder' },
  OutlinePreviewNormal = { link = 'XMenu' },
  RenameBorder = { link = 'XBorder' },
  RenameNormal = { link = 'XMenu' },
  SagaBorder = { link = 'XBorder' },
  SagaNormal = { link = 'XMenu' },
  SagaSep = { fg = colors.foreground, bg = 'none' },
  TerminalBorder = { link = 'XBorder' },
  TerminalNormal = { link = 'XMenu' },
  SagaShadow = { fg = colors.background, bg = colors.background },
  SpellBad = { undercurl = true },
  TitleIcon = { fg = colors.foreground, bg = colors.light_orange },
  TitleString = { fg = colors.background, bg = colors.light_orange },
  -- LSP
  LspReferenceText = { bg = colors.red, fg = colors.foreground },
  LspSignatureActiveParameter = { link = 'Search' },
  -- Neotree
  NeoTreeCursorLine = { link = 'Visual' },
  NeoTreeFloatBorder = { link = 'XBorder' },
  NeoTreeFloatTitle = { fg = colors.background, bg = colors.light_orange },
  NeoTreeTitleBar = { fg = colors.background, bg = colors.light_orange },
  -- NeoTreeNormal               = { bg = colors.background },
  NeoTreeNormal = { bg = 'none' },
  NeoTreeNormalNC = { bg = 'none' },
  -- Noice.nvim
  NoiceCmdlineIcon = { fg = colors.red },
  NoiceCmdlineIconInput = { fg = colors.red },
  NoiceCmdlineIconSearch = { fg = colors.red },
  NoiceCmdlinePopup = { link = 'XMenu' },
  NoiceCmdlinePopupBorder = { link = 'XBorder' },
  NoiceConfirm = { link = 'XMenu' },
  NoiceConfirmBorder = { link = 'XBorder' },
  NoicePopup = { link = 'XMenu' },
  NoicePopupBorder = { link = 'XBorder' },
  NoicePopupmenu = { link = 'XMenu' },
  NoicePopupmenuBorder = { link = 'XBorder' },
  -- notify.nvim
  NotifyERRORBorder = { fg = colors.background },
  NotifyWARNBorder = { fg = colors.background },
  NotifyINFOBorder = { fg = colors.background },
  NotifyDEBUGBorder = { fg = colors.background },
  NotifyTRACEBorder = { fg = colors.background },
  -- text fg only when using `minimal` notify style
  NotifyINFOIcon = { fg = colors.foreground },
  -- web-dev-icons
  -- DevIconDefault          = { fg = colors.dark_orange, bg = 'none' },
}

local function overrides()
  return {
    Title = vim.tbl_extend(
      'force',
      vim.api.nvim_get_hl_by_name('Title', true) or {},
      { bg = colors.background }
    ),

    DiagnosticVirtualTextError = vim.tbl_extend(
      'force',
      vim.api.nvim_get_hl_by_name('DiagnosticVirtualTextError', true) or {},
      { bg = 'none' }
    ),
    DiagnosticVirtualTextWarn = vim.tbl_extend(
      'force',
      vim.api.nvim_get_hl_by_name('DiagnosticVirtualTextWarn', true) or {},
      { bg = 'none' }
    ),
    DiagnosticVirtualTextInfo = vim.tbl_extend(
      'force',
      vim.api.nvim_get_hl_by_name('DiagnosticVirtualTextInfo', true) or {},
      { bg = 'none' }
    ),
    DiagnosticVirtualTextHint = vim.tbl_extend(
      'force',
      vim.api.nvim_get_hl_by_name('DiagnosticVirtualTextHint', true) or {},
      { bg = 'none' }
    ),
    DiagnosticSignError = vim.tbl_extend(
      'force',
      vim.api.nvim_get_hl_by_name('DiagnosticSignError', true) or {},
      { bg = 'none' }
    ),
    DiagnosticSignWarn = vim.tbl_extend(
      'force',
      vim.api.nvim_get_hl_by_name('DiagnosticSignWarn', true) or {},
      { bg = 'none' }
    ),
    DiagnosticSignInfo = vim.tbl_extend(
      'force',
      vim.api.nvim_get_hl_by_name('DiagnosticSignInfo', true) or {},
      { bg = 'none' }
    ),
    DiagnosticSignHint = vim.tbl_extend(
      'force',
      vim.api.nvim_get_hl_by_name('DiagnosticSignHint', true) or {},
      { bg = 'none' }
    ),
  }
end

local function load(gs)
  for group, opts in pairs(gs) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

function colors.load()
  load(base_groups)
  load(overrides())

  vim.g.terminal_color_0 = colors.background
end

return colors
