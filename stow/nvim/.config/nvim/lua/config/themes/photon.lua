local colors = {
  bg_00 = '#1c1c1c',
  bg_01 = '#222222',
  bg_02 = '#303030',
  dark_orange = '#ff5d62',
  foreground = '#d1d1d1',
  green = '#87af87',
  grey = '#888888',
  light_grey = '#767676',
  light_orange = '#ffa066',
  purple = '#af87d7',
  red = '#d75f5f',
  yellow = '#d7af5f',
}

local groups = {
  -- Groups
  MonoMenu                    = { bg = colors.bg_01, default = true },
  MonoBorder                  = { bg = colors.bg_01, fg = colors.bg_01, default = true },
  -- Base
  Normal                      = { fg = colors.foreground },
  NonText                     = { fg = colors.bg_00 },
  CursorLine                  = { bg = colors.bg_00 },
  CursorColumn                = { link = "CursorLine" },
  TabLineFill                 = { fg = colors.grey, bg = colors.bg_01 },
  TabLineSel                  = { fg = colors.green, bg = colors.bg_01 },
  TabLine                     = { link = "TabLineFill" },
  MatchParen                  = { bg = colors.bg_00, bold = true },
  ColorColumn                 = { bg = colors.bg_01 },
  Conceal                     = { fg = colors.yellow },
  CursorLineNr                = { fg = colors.foreground },
  SpecialKey                  = { fg = colors.light_grey },
  Visual                      = { bg = colors.bg_02 },
  VisualNOS                   = { link = "Visual" },
  Search                      = { fg = colors.dark_orange, bg = colors.bg_00 },
  IncSearch                   = { fg = colors.dark_orange, bg = colors.bg_00 },
  CurSearch                   = { fg = colors.dark_orange, bg = colors.bg_00 },
  QuickFixLine                = { fg = colors.bg_00, bg = colors.dark_orange, bold = true },
  Underlined                  = { underline = true },
  StatusLine                  = { fg = colors.grey, bg = colors.bg_00 },
  StatusLineNC                = { fg = nil, bg = colors.bg_00 },
  WinBar                      = { bg = colors.bg_00 },
  WinBarNC                    = { bg = colors.bg_00 },
  WinSeparator                = { fg = colors.bg_02, bg = colors.bg_00 },
  WildMenu                    = { fg = colors.purple, bg = colors.bg_01 },
  Directory                   = { fg = colors.grey },
  Title                       = { fg = colors.foreground, bold = true },
  ErrorMsg                    = { fg = colors.red, bg = colors.bg_00, bold = true },
  MoreMsg                     = { fg = colors.grey, bg = colors.bg_00 },
  ModeMsg                     = { fg = colors.grey },
  Question                    = { fg = colors.foreground },
  WarningMsg                  = { fg = colors.yellow, bg = colors.bg_00 },
  LineNr                      = { fg = colors.grey },
  SignColumn                  = { bg = nil },
  Folded                      = { fg = colors.grey, bg = nil },
  FoldColumn                  = { fg = colors.grey, bg = nil },
  Cursor                      = { fg = colors.bg_01, bg = colors.dark_orange },
  vCursor                     = { link = "Cursor" },
  iCursor                     = { link = "Cursor" },
  lCursor                     = { link = "Cursor" },
  Special                     = { fg = colors.dark_orange },
  Comment                     = { fg = colors.grey },
  helpHyperTextJump           = { bg = nil, fg = colors.purple },
  Todo                        = { fg = colors.dark_orange, bg = colors.bg_00, bold = true },
  Error                       = { fg = colors.red, bold = true },
  Statement                   = { link = 'Include' },
  Conditional                 = { fg = colors.grey },
  Repeat                      = { fg = colors.grey },
  Label                       = { fg = colors.dark_orange },
  Exception                   = { fg = colors.dark_orange },
  Operator                    = { fg = colors.grey },
  Keyword                     = { fg = colors.grey },
  Identifier                  = { fg = colors.foreground },
  Function                    = { fg = colors.foreground },
  PreProc                     = { fg = colors.dark_orange },
  Include                     = { fg = colors.grey },
  Define                      = { fg = colors.dark_orange },
  Macro                       = { fg = colors.dark_orange },
  PreCondit                   = { fg = colors.dark_orange },
  Constant                    = { fg = colors.foreground },
  Character                   = { fg = colors.dark_orange },
  String                      = { fg = colors.foreground },
  Boolean                     = { fg = colors.dark_orange },
  Number                      = { fg = colors.foreground },
  Float                       = { fg = colors.foreground },
  Type                        = { fg = colors.grey },
  StorageClass                = { fg = colors.dark_orange },
  Structure                   = { fg = colors.grey },
  Typedef                     = { fg = colors.foreground },
  Pmenu                       = { link = 'MonoMenu' },
  PmenuSel                    = { fg = colors.bg_01, bg = colors.dark_orange, bold = true },
  PmenuSbar                   = { bg = colors.bg_01 },
  PmenuThumb                  = { bg = colors.bg_01 },
  DiffDelete                  = { fg = colors.red, reverse = true },
  DiffAdd                     = { fg = colors.green, reverse = true },
  DiffChange                  = { fg = colors.yellow, reverse = true },
  DiffText                    = { fg = colors.purple, reverse = true },
  SpellCap                    = { fg = colors.yellow, undercurl = true },
  SpellBad                    = { undercurl = true },
  SpellLocal                  = { undercurl = true },
  SpellRare                   = { undercurl = true },
  -- Whitespace                  = { fg = colors.bg_00 },
  -- LSP Diagnostic
  DiagnosticBorder            = { link = 'MonoBorder' },
  DiagnosticNormal            = { link = 'MonoMenu' },
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
  -- Floats and Menus
  FloatBorder                 = { link = 'MonoBorder' },
  ActionPreviewBorder         = { link = 'MonoBorder' },
  ActionPreviewNormal         = { link = 'MonoMenu' },
  CallHierarchyBorder         = { link = 'MonoBorder' },
  CallHierarchyNormal         = { link = 'MonoMenu' },
  CodeActionBorder            = { link = 'MonoBorder' },
  CodeActionNormal            = { link = 'MonoMenu' },
  DefinitionBorder            = { link = 'MonoBorder' },
  DefinitionNormal            = { link = 'MonoMenu' },
  FinderBorder                = { link = 'MonoBorder' },
  FinderNormal                = { link = 'MonoMenu' },
  HoverBorder                 = { link = 'MonoBorder' },
  HoverNormal                 = { link = 'MonoMenu' },
  OutlinePreviewBorder        = { link = 'MonoBorder' },
  OutlinePreviewNormal        = { link = 'MonoMenu' },
  RenameBorder                = { link = 'MonoBorder' },
  RenameNormal                = { link = 'MonoMenu' },
  TerminalBorder              = { link = 'MonoBorder' },
  TerminalNormal              = { link = 'MonoMenu' },
  SagaNormal                  = { link = 'MonoMenu' },
  SagaBorder                  = { link = 'MonoBorder' },
  -- Mason
  MasonHeader                 = { link = 'MonoMenu' },
  MasonNormal                 = { link = 'MonoMenu' },
  -- Telescope
  TelescopeBorder             = { link = 'MonoBorder' },
  TelescopePromptBorder       = { link = 'MonoBorder' },
  TelescopePromptNormal       = { link = 'MonoMenu', fg = colors.foreground },
  TelescopePromptPrefix       = { link = 'MonoMenu', fg = colors.light_orange },
  TelescopeNormal             = { bg = colors.bg_00 },
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
  Debug                       = { fg = colors.dark_orange },
  Delimiter                   = { fg = colors.grey },
  Ignore                      = { fg = colors.grey },
  SpecialChar                 = { fg = colors.dark_orange },
  SpecialComment              = { fg = colors.dark_orange },
  Tag                         = { fg = colors.dark_orange },
  -- Rest
  NormalFloat                 = { link = 'MonoMenu' },
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
  SagaShadow                  = { fg = colors.bg_00, bg = colors.background },
  -- neotree.nvim
  NeoTreeCursorLine           = { bg = colors.bg_01, fg = colors.dark_orange },
  DevIconDefault              = { bg = nil, fg = colors.dark_orange },
  NoiceCmdlineIcon            = { fg = colors.dark_orange },
  NoiceCmdlinePopupBorder     = { link = 'MonoBorder' },
}

-- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
local tree_sitter_groups = {
  -- Misc
  ['@comment']               = { link = 'Comment' },        -- line and block comments
  ['@comment.documentation'] = { link = 'Comment' },        -- comments documenting code
  ['@error']                 = { fg = colors.dark_orange }, -- syntax/parser errors
  -- ['@none']                  = { bg = nil, fg = nil },                  -- completely disable the highlight
  ['@preproc']               = { link = 'PreProc' },        -- various preprocessor directives & shebangs
  ['@define']                = { link = 'Define' },         -- preprocessor definition directives
  ['@operator']              = { link = 'Operator' },       -- symbolic operators (e.g. `+` / `*`)
  -- Punctuation
  ['@punctuation.delimiter'] = { fg = colors.grey },        -- delimiters (e.g. `;` / `.` / `,`)
  ['@punctuation.bracket']   = { fg = colors.grey },        -- brackets (e.g. `()` / `{}` / `[]`)
  ['@punctuation.special']   = { fg = colors.dark_orange }, -- special symbols (e.g. `{}` in string interpolation)
  -- Literals
  ['@string']                = { link = 'String' },         -- string literals
  ['@string.documentation']  = { fg = colors.dark_orange }, -- string documenting code (e.g. Python docstrings)
  ['@string.regex']          = { fg = colors.dark_orange }, -- regular expressions
  ['@string.escape']         = { fg = colors.dark_orange }, -- escape sequences
  ['@string.special']        = { fg = colors.dark_orange }, -- other special strings (e.g. dates)
  ['@character']             = { fg = colors.grey },        -- character literals
  ['@character.special']     = { fg = colors.dark_orange }, -- special characters (e.g. wildcards)
  ['@boolean']               = { link = 'Boolean' },        -- boolean literals
  ['@number']                = { link = 'Number' },         -- numeric literals
  ['@float']                 = { link = 'Number' },         -- floating-point number literals
  -- Functions
  ['@function']              = { link = 'Function' },       -- function definitions
  ['@function.builtin']      = { fg = colors.dark_orange }, -- built-in functions
  ['@function.call']         = { fg = colors.foreground },  -- function calls
  ['@function.macro']        = { fg = colors.dark_orange }, -- preprocessor macros
  ['@method']                = { fg = colors.foreground },  -- method definitions
  ['@method.call']           = { fg = colors.foreground },  -- method calls
  ['@constructor']           = { fg = colors.foreground },  -- constructor calls and definitions
  ['@parameter']             = { fg = colors.foreground },  -- parameters of a function
  -- Keywords
  ['@keyword']               = { link = 'Keyword' },        -- various keywords
  ['@keyword.coroutine']     = { fg = colors.purple },      -- keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
  ['@keyword.function']      = { fg = colors.grey },        -- keywords that define a function (e.g. `func` in Go, `def` in Python)
  ['@keyword.operator']      = { fg = colors.dark_orange }, -- operators that are English words (e.g. `and` / `or`)
  ['@keyword.return']        = { fg = colors.grey },        -- keywords like `return` and `yield`
  ['@conditional']           = { fg = colors.grey },        -- keywords related to conditionals (e.g. `if` / `else`)
  ['@conditional.ternary']   = { fg = colors.purple },      -- ternary operator (e.g. `?` / `:`)
  ['@repeat']                = { fg = colors.grey },        -- keywords related to loops (e.g. `for` / `while`)
  ['@debug']                 = { link = 'Debug' },          -- keywords related to debugging
  ['@label']                 = { fg = colors.dark_orange }, -- GOTO and other labels (e.g. `label:` in C)
  ['@include']               = { link = 'Include' },        -- keywords for including modules (e.g. `import` / `from` in Python)
  ['@exception']             = { link = 'Exception' },      -- keywords related to exceptions (e.g. `throw` / `catch`)
  -- Types
  ['@type']                  = { link = 'Type' },           -- type or class definitions and annotations
  ['@type.toml']             = { fg = colors.foreground },
  ['@type.builtin']          = { fg = colors.grey },        -- built-in types
  ['@type.definition']       = { link = 'Typedef' },        -- type definitions (e.g. `typedef` in C)
  ['@type.qualifier']        = { fg = colors.grey },        -- type qualifiers (e.g. `const`)
  ['@storageclass']          = { fg = colors.dark_orange }, -- modifiers that affect storage in memory or life-time
  ['@attribute']             = { fg = colors.dark_orange }, -- attribute annotations (e.g. Python decorators)
  ['@field']                 = { fg = colors.foreground },  -- object and struct fields
  ['@field.yaml']            = { fg = colors.dark_orange },
  ['@field.toml']            = { fg = colors.dark_orange },
  ['@property']              = { fg = colors.grey },                    -- similar to `@field`
  -- Identifiers
  ['@variable']              = { fg = colors.foreground },              -- various variable names
  ['@variable.builtin']      = { fg = colors.purple },                  -- built-in variable names (e.g. `this`)
  ['@constant']              = { fg = colors.foreground },              -- constant identifiers
  ['@constant.builtin']      = { fg = colors.dark_orange },             -- built-in constant values
  ['@constant.macro']        = { fg = colors.dark_orange },             -- constants defined by the preprocessor
  ['@namespace']             = { fg = colors.foreground },              -- modules or namespaces
  ['@symbol']                = { fg = colors.purple },                  -- symbols or atoms
  -- Text - Mainly markup languages
  ['@text']                  = { fg = colors.grey },                    -- non-structured text
  ['@text.strong']           = { fg = colors.foreground, bold = true }, -- bold text
  ['@text.emphasis']         = { fg = colors.foreground },              -- text with emphasis
  ['@text.underline']        = { link = 'Underlined' },                 -- underlined text
  ['@text.strike']           = { fg = colors.grey },                    -- strikethrough text
  ['@text.title']            = { link = 'Title' },                      -- text that is part of a title
  ['@text.literal']          = { fg = colors.grey },                    -- literal or verbatim text (e.g., inline code)
  ['@text.quote']            = { fg = colors.foreground },              -- text quotations
  ['@text.uri']              = { fg = colors.grey, undercurl = true },  -- URIs (e.g. hyperlinks)
  ['@text.math']             = { fg = colors.foreground },              -- math environments (e.g. `$ ... $` in LaTeX)
  ['@text.environment']      = { fg = colors.grey },                    -- text environments of markup languages
  ['@text.environment.name'] = { fg = colors.grey },                    -- text indicating the type of an environment
  ['@text.reference']        = { fg = colors.foreground },              -- text references, footnotes, citations, etc.
  ['@text.todo']             = { link = 'Todo' },                       -- todo notes
  ['@text.note']             = { link = 'Todo' },                       -- info notes
  ['@text.warning']          = { fg = colors.yellow },                  -- warning notes
  ['@text.danger']           = { fg = colors.dark_orange },             -- danger/error notes
  ['@text.diff.add']         = { fg = colors.green },                   -- added text (for diff files)
  ['@text.diff.delete']      = { fg = colors.dark_orange },             -- deleted text (for diff files)
  -- Tags
  ['@tag']                   = { link = 'Tag' },                        -- XML tag names
  ['@tag.attribute']         = { link = 'Tag' },                        -- XML tag attributes
  ['@tag.delimiter']         = { link = 'Tag' },                        -- XML tag delimiters
  -- @conceal ; for captures that are only used for concealing
  -- Spell
  -- @spell   ; for defining regions to be spellchecked
  -- @nospell ; for defining regions that should NOT be spellchecked
  -- Locals
  ['@definition']            = { fg = colors.grey },        -- various definitions
  ['@definition.constant']   = { fg = colors.grey },        -- constants
  ['@definition.function']   = { fg = colors.foreground },  -- functions
  ['@definition.method']     = { fg = colors.grey },        -- methods
  ['@definition.var']        = { fg = colors.grey },        -- variables
  ['@definition.parameter']  = { fg = colors.grey },        -- parameters
  ['@definition.macro']      = { fg = colors.grey },        -- preprocessor macros
  ['@definition.type']       = { fg = colors.grey },        -- types or classes
  ['@definition.field']      = { fg = colors.foreground },  -- fields or properties
  ['@definition.enum']       = { fg = colors.grey },        -- enumerations
  ['@definition.namespace']  = { fg = colors.grey },        -- modules or namespaces
  ['@definition.import']     = { fg = colors.grey },        -- imported names
  ['@definition.associated'] = { fg = colors.grey },        -- the associated type of a variable
  ['@scope']                 = { fg = colors.grey },        -- scope block
  ['@reference']             = { fg = colors.dark_orange }, -- identifier reference
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
