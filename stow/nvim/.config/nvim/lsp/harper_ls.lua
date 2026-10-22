---@brief
---
--- https://github.com/automattic/harper
---
--- See our [documentation](https://writewithharper.com/docs/integrations/neovim) for more information on settings.
---@type vim.lsp.Config
return {
  cmd = { 'harper-ls', '--stdio' },
  filetypes = {
    'asciidoc',
    'gitcommit',
    'markdown',
    'text',
    'tex',
  },
  root_markers = { '.git', '.harper-dictionary.txt' },
  settings = {
    linters = {
      SpellCheck = true,
      SpelledNumbers = false,
      AnA = true,
      SentenceCapitalization = true,
      UnclosedQuotes = true,
      WrongApostrophe = false,
      LongSentences = true,
      RepeatedWords = true,
      Spaces = true,
      CorrectNumberSuffix = true,
    },
  },
}
