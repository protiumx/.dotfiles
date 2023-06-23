local colors = {
  bg_00 = '#161616',
  bg_01 = '#1a1a1a',
  bg_02 = '#303030',
  dark_orange = '#ff5d62',
  foreground = '#fbf1c7',
  green = '#87af87',
  grey = '#a89984',
  light_grey = '#767676',
  light_orange = '#ffa066',
  purple = '#af87d7',
  red = '#fb4934',
  yellow = '#d7af5f',
}

local groups = {
  MonoMenu                    = { bg = colors.bg_01, default = true, fg = colors.foreground },
  MonoBorder                  = { bg = colors.bg_01, fg = colors.bg_01, default = true },
  -- Base
  Normal                      = { fg = colors.foreground, bg = colors.bg_00 },
  NormalFloat                 = { link = 'MonoMenu' },
  NonText                     = { fg = colors.bg_02 },
  EndOfBuffer                 = { fg = colors.bg_00 },
  CursorColumn                = { bg = colors.bg_00 },
  FloatBorder                 = { link = 'MonoBorder' },
  TabLineFill                 = { fg = colors.grey, bg = colors.bg_01 },
  TabLineSel                  = { fg = colors.green, bg = colors.bg_01 },
  TabLine                     = { link = "TabLineFill" },
  MatchParen                  = { bg = colors.bg_00, fg = colors.red, bold = true },
  ColorColumn                 = { bg = colors.bg_01 },
  Conceal                     = { fg = colors.bg_00 },
  CursorLine                  = { bg = 'none' },
  CursorLineNr                = { fg = colors.foreground },
  SpecialKey                  = { fg = colors.foreground },
  Visual                      = { bg = colors.bg_02 },
  VisualNOS                   = { link = "Visual" },
  Search                      = { fg = colors.red, bg = colors.bg_00 },
  IncSearch                   = { fg = colors.red, bg = colors.bg_00 },
  CurSearch                   = { fg = colors.red, bg = colors.bg_00 },
  QuickFixLine                = { fg = colors.bg_00, bg = colors.dark_orange, bold = true },
  Underlined                  = { underline = true },
  StatusLine                  = { fg = colors.grey, bg = colors.bg_00 },
  StatusLineNC                = { fg = 'none', bg = colors.bg_00 },
  WinBar                      = { bg = colors.bg_00 },
  WinBarNC                    = { bg = colors.bg_00 },
  WinSeparator                = { fg = colors.bg_02, bg = 'none' },
  WildMenu                    = { fg = colors.red, bg = colors.bg_01 },
  Directory                   = { fg = colors.foreground },
  Title                       = { fg = colors.foreground, bold = true },
  ErrorMsg                    = { fg = colors.red, bg = colors.bg_00, bold = true },
  MoreMsg                     = { fg = colors.grey, bg = colors.bg_00 },
  ModeMsg                     = { fg = colors.grey },
  Question                    = { fg = colors.foreground },
  WarningMsg                  = { fg = colors.yellow, bg = colors.bg_00 },
  LineNr                      = { fg = colors.grey },
  SignColumn                  = { bg = 'none' },
  Folded                      = { fg = colors.grey, bg = nil },
  FoldColumn                  = { fg = colors.grey, bg = nil },
  Cursor                      = { fg = colors.bg_00, bg = colors.dark_orange },
  vCursor                     = { link = "Cursor" },
  iCursor                     = { link = "Cursor" },
  lCursor                     = { link = "Cursor" },
  Special                     = { fg = colors.foreground },
  Comment                     = { fg = colors.grey },
  helpHyperTextJump           = { bg = 'none', fg = colors.red },
  Pmenu                       = { link = 'MonoMenu' },
  PmenuSel                    = { fg = colors.bg_01, bg = colors.red, bold = true },
  PmenuSbar                   = { bg = colors.bg_01 },
  PmenuThumb                  = { bg = colors.bg_01 },
  DiffDelete                  = { fg = colors.red, reverse = true },
  DiffAdd                     = { fg = colors.green, reverse = true },
  DiffChange                  = { fg = colors.yellow, reverse = true },
  DiffText                    = { fg = colors.bg_00, bg = colors.green },
  SpellCap                    = { fg = colors.yellow, undercurl = true },
  SpellBad                    = { undercurl = true },
  SpellLocal                  = { undercurl = true },
  SpellRare                   = { undercurl = true },
  -- Whitespace                  = { fg = colors.bg_00 },
  -- lspsaga.nvim
  ActionPreviewBorder         = { link = 'MonoBorder' },
  ActionPreviewNormal         = { link = 'MonoMenu' },
  ActionPreviewTitle          = { link = 'MonoMenu' },
  CallHierarchyBorder         = { link = 'MonoBorder' },
  CallHierarchyNormal         = { link = 'MonoMenu' },
  DefinitionBorder            = { link = 'MonoBorder' },
  DefinitionNormal            = { link = 'MonoMenu' },
  DiagnosticBorder            = { link = 'MonoBorder' },
  DiagnosticNormal            = { link = 'MonoMenu' },
  DiagnosticShowNormal        = { link = 'MonoMenu' },
  DiagnosticShowBorder        = { link = 'MonoBorder' },
  FinderBorder                = { link = 'MonoBorder' },
  FinderNormal                = { link = 'MonoMenu' },
  HoverBorder                 = { link = 'MonoBorder' },
  HoverNormal                 = { link = 'MonoMenu' },
  OutlinePreviewBorder        = { link = 'MonoBorder' },
  OutlinePreviewNormal        = { link = 'MonoMenu' },
  RenameBorder                = { link = 'MonoBorder' },
  RenameNormal                = { link = 'MonoMenu' },
  SagaBorder                  = { link = 'MonoBorder' },
  SagaNormal                  = { link = 'MonoMenu' },
  TerminalBorder              = { link = 'MonoBorder' },
  TerminalNormal              = { link = 'MonoMenu' },
  SagaShadow                  = { fg = colors.background, bg = colors.background },
  TitleIcon                   = { fg = colors.foreground, bg = colors.light_orange },
  TitleString                 = { fg = colors.background, bg = colors.light_orange },
  -- LSP Diagnostic
  DiagnosticError             = { fg = colors.red },
  DiagnosticSignError         = { fg = colors.red },
  DiagnosticUnderlineError    = { undercurl = true },
  DiagnosticWarn              = { fg = colors.yellow },
  DiagnosticSignWarn          = { fg = colors.yellow },
  DiagnosticUnderlineWarn     = { undercurl = true },
  DiagnosticInfo              = { fg = colors.foreground },
  DiagnosticSignInfo          = { fg = colors.foreground },
  DiagnosticUnderlineInfo     = { undercurl = true },
  DiagnosticHint              = { fg = colors.grey },
  DiagnosticSignHint          = { fg = colors.grey },
  DiagnosticUnderlineHint     = { undercurl = true },
  DiagnosticFloatingError     = { link = 'DiagnosticError' },
  DiagnosticFloatingWarn      = { link = "DiagnosticWarn" },
  DiagnosticFloatingInfo      = { link = "DiagnosticInfo" },
  DiagnosticFloatingHint      = { link = "DiagnosticHint" },
  DiagnosticVirtualTextError  = { link = "DiagnosticError" },
  DiagnosticVirtualTextWarn   = { link = "DiagnosticWarn" },
  DiagnosticVirtualTextInfo   = { link = "DiagnosticInfo" },
  DiagnosticVirtualTextHint   = { link = "DiagnosticHint" },
  LspReferenceRead            = { fg = colors.dark_orange, bold = true },
  LspReferenceText            = { fg = colors.dark_orange, bold = true },
  LspReferenceWrite           = { fg = colors.dark_orange, bold = true },
  LspCodeLens                 = { fg = colors.grey },
  LspSignatureActiveParameter = { link = "Search" },
  -- Git
  diffAdded                   = { fg = colors.green },
  diffRemoved                 = { fg = colors.red },
  diffChanged                 = { fg = colors.yellow },
  diffFile                    = { fg = colors.foreground },
  diffNewFile                 = { fg = colors.green },
  diffOldFile                 = { fg = colors.grey },
  diffLine                    = { fg = colors.grey },
  diffIndexLine               = { fg = colors.grey },
  -- gitcommit
  gitcommitSelectedFile       = { fg = colors.green },
  gitcommitDiscardedFile      = { fg = colors.red },
  -- gitsigns.nvim
  GitSignsAdd                 = { fg = colors.green },
  GitSignsChange              = { fg = colors.yellow },
  GitSignsDelete              = { fg = colors.red },
  netrwDir                    = { fg = colors.grey },
  netrwClassify               = { fg = colors.grey },
  netrwLink                   = { fg = colors.foreground },
  netrwSymLink                = { fg = colors.purple },
  netrwExe                    = { fg = colors.foreground },
  netrwComment                = { link = 'Comment' },
  netrwList                   = { fg = colors.grey },
  netrwHelpCmd                = { fg = colors.grey },
  netrwCmdSep                 = { fg = colors.bg_02 },
  netrwVersion                = { fg = colors.grey },
  -- Mason
  MasonHeader                 = { link = 'MonoMenu' },
  MasonNormal                 = { link = 'MonoMenu' },
  -- Telescope
  TelescopeBorder             = { link = 'MonoBorder' },
  TelescopePromptBorder       = { link = 'MonoBorder' },
  TelescopePromptNormal       = { link = 'MonoMenu', fg = colors.foreground },
  TelescopePromptPrefix       = { link = 'MonoMenu', fg = colors.light_orange },
  TelescopeNormal             = { bg = colors.bg_01, fg = colors.foreground },
  TelescopePreviewBorder      = { link = 'MonoBorder' },
  TelescopePreviewNormal      = { link = 'MonoMenu' },
  TelescopePreviewTitle       = { fg = colors.bg_00, bg = colors.light_orange },
  TelescopePreviewLine        = { fg = colors.bg_00, bg = colors.light_orange },
  TelescopePromptTitle        = { fg = colors.bg_00, bg = colors.light_orange },
  TelescopeResultsTitle       = { fg = colors.bg_00, bg = colors.light_orange },
  TelescopeResultsBorder      = { link = 'MonoBorder' },
  TelescopeResultsNormal      = { link = 'MonoMenu' },
  -- Transparent bg_00
  FoldCoumn                   = { bg = 'none' },
  NormalNC                    = { bg = 'none', fg = colors.foreground },
  -- Language Syntax
  Boolean                     = { fg = colors.foreground },
  Character                   = { fg = colors.foreground },
  Conditional                 = { fg = colors.foreground },
  Constant                    = { fg = colors.foreground },
  Debug                       = { fg = colors.dark_orange },
  Define                      = { fg = colors.foreground },
  Delimiter                   = { fg = colors.grey },
  Error                       = { fg = colors.red, bold = true },
  Exception                   = { fg = colors.grey },
  Float                       = { fg = colors.foreground },
  Function                    = { fg = colors.foreground },
  Identifier                  = { fg = colors.foreground },
  Ignore                      = { fg = colors.grey },
  Include                     = { fg = colors.grey },
  Keyword                     = { fg = colors.grey },
  Label                       = { fg = colors.grey },
  Macro                       = { fg = colors.foreground },
  Number                      = { fg = colors.foreground },
  Operator                    = { fg = colors.grey },
  PreCondit                   = { fg = colors.foreground },
  PreProc                     = { fg = colors.foreground },
  Repeat                      = { fg = colors.foreground },
  SpecialChar                 = { fg = colors.dark_orange },
  SpecialComment              = { fg = colors.dark_orange },
  Statement                   = { link = 'Include' },
  StorageClass                = { fg = colors.foreground },
  String                      = { fg = colors.foreground },
  Structure                   = { fg = colors.foreground },
  Tag                         = { fg = colors.dark_orange },
  Todo                        = { fg = colors.red, bg = colors.bg_00, bold = true },
  Type                        = { fg = colors.foreground },
  Typedef                     = { fg = colors.foreground },
  -- nvim-cmp
  CmpItemAbbr                 = { fg = colors.foreground },
  CmpItemAbbrMatch            = { fg = colors.dark_orange },
  CmpItemAbbrMatchFuzzy       = { fg = colors.dark_orange },
  CmpBorder                   = { link = 'MonoBorder' },
  CmpDocBorder                = { link = 'MonoBorder' },
  CmpItemMenuDefault          = { link = 'NormalFloat' },
  CmpMenu                     = { link = 'MonoMenu' },
  CmpItemKindConstant         = { fg = colors.grey },
  CmpItemKindFunction         = { fg = colors.grey },
  CmpItemKindIdentifier       = { fg = colors.grey },
  CmpItemKindField            = { fg = colors.grey },
  CmpItemKindVariable         = { fg = colors.grey },
  CmpItemKindSnippet          = { fg = colors.grey },
  CmpItemKindText             = { fg = colors.grey },
  CmpItemKindStructure        = { fg = colors.grey },
  CmpItemKindType             = { fg = colors.grey },
  CmpItemKindKeyword          = { fg = colors.grey },
  CmpItemKindMethod           = { fg = colors.grey },
  CmpItemKindConstructor      = { fg = colors.grey },
  CmpItemKindFolder           = { fg = colors.grey },
  CmpItemKindModule           = { fg = colors.grey },
  CmpItemKindProperty         = { fg = colors.grey },
  CmpItemKindEnum             = { fg = colors.grey },
  CmpItemKindUnit             = { fg = colors.grey },
  CmpItemKindClass            = { fg = colors.grey },
  CmpItemKindFile             = { fg = colors.grey },
  CmpItemKindInterface        = { fg = colors.grey },
  CmpItemKindColor            = { fg = colors.grey },
  CmpItemKindReference        = { fg = colors.grey },
  CmpItemKindEnumMember       = { fg = colors.grey },
  CmpItemKindStruct           = { fg = colors.grey },
  CmpItemKindValue            = { fg = colors.grey },
  CmpItemKindEvent            = { fg = colors.grey },
  CmpItemKindOperator         = { fg = colors.grey },
  CmpItemKindTypeParameter    = { fg = colors.grey },
  CmpItemKindCopilot          = { fg = colors.grey },
  -- Diffview
  DiffViewSignColumn          = { bg = nil },
  DiffViewFilePanelSelected   = { bg = colors.bg_00, fg = colors.red },
  -- lspsaga.nvim
  LspSagaCodeActionTitle      = { link = "Title" },
  LspSagaCodeActionBorder     = { link = 'MonoBorder' },
  LspSagaCodeActionContent    = { fg = colors.grey },
  LspSagaLspFinderBorder      = { link = 'MonoBorder' },
  LspSagaAutoPreview          = { fg = colors.grey },
  TargetWord                  = { fg = colors.dark_orange, bold = true },
  FinderSeparator             = { fg = colors.bg_02 },
  LspSagaDefPreviewBorder     = { link = "MonoBorder" },
  LspSagaHoverBorder          = { link = "MonoBorder" },
  LspSagaRenameBorder         = { link = "MonoBorder" },
  LspSagaDiagnosticSource     = { fg = colors.dark_orange },
  LspSagaDiagnosticBorder     = { link = "MonoBorder" },
  LspSagaDiagnosticHeader     = { fg = colors.bg_00, bg = colors.dark_orange },
  LspSagaSignatureHelpBorder  = { link = "MonoBorder" },
  -- neotree.nvim
  NeoTreeCursorLine           = { bg = colors.bg_01, fg = colors.dark_orange },
  DevIconDefault              = { bg = nil, fg = colors.dark_orange },
  NoiceCmdlineIcon            = { fg = colors.red },
  NoiceCmdlineIconInput       = { fg = colors.red },
  NoiceCmdlineIconSearch      = { fg = colors.red },
  NoiceCmdlinePopupBorder     = { link = 'MonoBorder' },
  -- Notify.nvim
  NotifyERRORBorder           = { fg = colors.bg_00 },
  NotifyWARNBorder            = { fg = colors.bg_00 },
  NotifyINFOBorder            = { fg = colors.bg_00 },
  NotifyDEBUGBorder           = { fg = colors.bg_00 },
  NotifyTRACEBorder           = { fg = colors.bg_00 },
}

-- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
local tree_sitter_groups = {
  -- Misc
  ['@comment']               = { link = 'Comment' },       -- line and block comments
  ['@comment.documentation'] = { link = 'Comment' },       -- comments documenting code
  ['@error']                 = { fg = colors.red },        -- syntax/parser errors
  -- ['@none']                  = { bg = nil, fg = nil },                  -- completely disable the highlight
  ['@preproc']               = { link = 'PreProc' },       -- various preprocessor directives & shebangs
  ['@define']                = { link = 'Define' },        -- preprocessor definition directives
  ['@operator']              = { link = 'Operator' },      -- symbolic operators (e.g. `+` / `*`)
  -- Punctuation
  ['@punctuation.delimiter'] = { fg = colors.grey },       -- delimiters (e.g. `;` / `.` / `,`)
  ['@punctuation.bracket']   = { fg = colors.grey },       -- brackets (e.g. `()` / `{}` / `[]`)
  ['@punctuation.special']   = { fg = colors.foreground }, -- special symbols (e.g. `{}` in string interpolation)
  -- Literals
  ['@string']                = { link = 'String' },        -- string literals
  ['@string.documentation']  = { fg = colors.grey },       -- string documenting code (e.g. Python docstrings)
  ['@string.regex']          = { fg = colors.foreground }, -- regular expressions
  ['@string.escape']         = { fg = colors.foreground }, -- escape sequences
  ['@string.special']        = { fg = colors.foreground }, -- other special strings (e.g. dates)
  ['@character']             = { fg = colors.foreground }, -- character literals
  ['@character.special']     = { fg = colors.foreground }, -- special characters (e.g. wildcards)
  ['@boolean']               = { link = 'Boolean' },       -- boolean literals
  ['@number']                = { link = 'Number' },        -- numeric literals
  ['@float']                 = { link = 'Number' },        -- floating-point number literals
  -- Functions
  ['@function']              = { link = 'Function' },      -- function definitions
  ['@function.builtin']      = { fg = colors.foreground }, -- built-in functions
  ['@function.call']         = { fg = colors.foreground }, -- function calls
  ['@function.macro']        = { fg = colors.foreground }, -- preprocessor macros
  ['@method']                = { fg = colors.foreground }, -- method definitions
  ['@method.call']           = { fg = colors.foreground }, -- method calls
  ['@constructor']           = { fg = colors.foreground }, -- constructor calls and definitions
  ['@parameter']             = { fg = colors.foreground }, -- parameters of a function
  -- Keywords
  ['@keyword']               = { link = 'Keyword' },       -- various keywords
  ['@keyword.coroutine']     = { fg = colors.grey },       -- keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
  ['@keyword.function']      = { fg = colors.grey },       -- keywords that define a function (e.g. `func` in Go, `def` in Python)
  ['@keyword.operator']      = { fg = colors.grey },       -- operators that are English words (e.g. `and` / `or`)
  ['@keyword.return']        = { fg = colors.grey },       -- keywords like `return` and `yield`
  ['@conditional']           = { fg = colors.grey },       -- keywords related to conditionals (e.g. `if` / `else`)
  ['@conditional.ternary']   = { fg = colors.grey },       -- ternary operator (e.g. `?` / `:`)
  ['@repeat']                = { fg = colors.grey },       -- keywords related to loops (e.g. `for` / `while`)
  ['@debug']                 = { link = 'Debug' },         -- keywords related to debugging
  ['@label']                 = { fg = colors.grey },       -- GOTO and other labels (e.g. `label:` in C)
  ['@include']               = { link = 'Include' },       -- keywords for including modules (e.g. `import` / `from` in Python)
  ['@exception']             = { link = 'Exception' },     -- keywords related to exceptions (e.g. `throw` / `catch`)
  -- Types
  ['@type']                  = { link = 'Type' },          -- type or class definitions and annotations
  ['@type.toml']             = { fg = colors.foreground },
  ['@type.builtin']          = { fg = colors.foreground }, -- built-in types
  ['@type.definition']       = { link = 'Typedef' },       -- type definitions (e.g. `typedef` in C)
  ['@type.qualifier']        = { fg = colors.foreground }, -- type qualifiers (e.g. `const`)
  ['@storageclass']          = { fg = colors.foreground }, -- modifiers that affect storage in memory or life-time
  ['@attribute']             = { fg = colors.foreground }, -- attribute annotations (e.g. Python decorators)
  ['@field']                 = { fg = colors.foreground }, -- object and struct fields
  ['@field.yaml']            = { fg = colors.foreground },
  ['@field.toml']            = { fg = colors.foreground },
  ['@property']              = { fg = colors.foreground },                   -- similar to `@field`
  -- Identifiers
  ['@variable']              = { fg = colors.foreground },                   -- various variable names
  ['@variable.builtin']      = { fg = colors.foreground },                   -- built-in variable names (e.g. `this`)
  ['@constant']              = { fg = colors.foreground },                   -- constant identifiers
  ['@constant.builtin']      = { fg = colors.foreground },                   -- built-in constant values
  ['@constant.macro']        = { fg = colors.foreground },                   -- constants defined by the preprocessor
  ['@namespace']             = { fg = colors.foreground },                   -- modules or namespaces
  ['@symbol']                = { fg = colors.foreground },                   -- symbols or atoms
  -- Text - Mainly markup languages
  ['@text']                  = { fg = colors.foreground },                   -- non-structured text
  ['@text.strong']           = { fg = colors.foreground, bold = true },      -- bold text
  ['@text.emphasis']         = { fg = colors.foreground },                   -- text with emphasis
  ['@text.underline']        = { link = 'Underlined' },                      -- underlined text
  ['@text.strike']           = { fg = colors.foreground },                   -- strikethrough text
  ['@text.title']            = { link = 'Title' },                           -- text that is part of a title
  ['@text.literal']          = { fg = colors.foreground },                   -- literal or verbatim text (e.g., inline code)
  ['@text.quote']            = { fg = colors.foreground },                   -- text quotations
  ['@text.uri']              = { fg = colors.foreground, undercurl = true }, -- URIs (e.g. hyperlinks)
  ['@text.math']             = { fg = colors.foreground },                   -- math environments (e.g. `$ ... $` in LaTeX)
  ['@text.environment']      = { fg = colors.foreground },                   -- text environments of markup languages
  ['@text.environment.name'] = { fg = colors.foreground },                   -- text indicating the type of an environment
  ['@text.reference']        = { fg = colors.foreground },                   -- text references, footnotes, citations, etc.
  ['@text.todo']             = { link = 'Todo' },                            -- todo notes
  ['@text.note']             = { link = 'Todo' },                            -- info notes
  ['@text.warning']          = { fg = colors.yellow },                       -- warning notes
  ['@text.danger']           = { fg = colors.red },                          -- danger/error notes
  ['@text.diff.add']         = { fg = colors.green },                        -- added text (for diff files)
  ['@text.diff.delete']      = { fg = colors.red },                          -- deleted text (for diff files)
  -- Tags
  ['@tag']                   = { link = 'Tag' },                             -- XML tag names
  ['@tag.attribute']         = { link = 'Tag' },                             -- XML tag attributes
  ['@tag.delimiter']         = { link = 'Tag' },                             -- XML tag delimiters
  -- @conceal ; for captures that are only used for concealing
  -- Spell
  -- @spell   ; for defining regions to be spellchecked
  -- @nospell ; for defining regions that should NOT be spellchecked
  -- Locals
  ['@definition']            = { fg = colors.foreground }, -- various definitions
  ['@definition.constant']   = { fg = colors.foreground }, -- constants
  ['@definition.function']   = { fg = colors.foreground }, -- functions
  ['@definition.method']     = { fg = colors.foreground }, -- methods
  ['@definition.var']        = { fg = colors.foreground }, -- variables
  ['@definition.parameter']  = { fg = colors.foreground }, -- parameters
  ['@definition.macro']      = { fg = colors.foreground }, -- preprocessor macros
  ['@definition.type']       = { fg = colors.foreground }, -- types or classes
  ['@definition.field']      = { fg = colors.foreground }, -- fields or properties
  ['@definition.enum']       = { fg = colors.foreground }, -- enumerations
  ['@definition.namespace']  = { fg = colors.foreground }, -- modules or namespaces
  ['@definition.import']     = { fg = colors.foreground }, -- imported names
  ['@definition.associated'] = { fg = colors.foreground }, -- the associated type of a variable
  ['@scope']                 = { fg = colors.foreground }, -- scope block
  ['@reference']             = { fg = colors.foreground }, -- identifier reference
}

local M = {}

function M.load()
  vim.cmd [[hi clear]]

  for group, hl in pairs(groups) do
    vim.api.nvim_set_hl(0, group, hl)
  end

  for group, hl in pairs(tree_sitter_groups) do
    vim.api.nvim_set_hl(0, group, hl)
  end

  vim.g.terminal_color_0 = colors.bg_01
end

return M
