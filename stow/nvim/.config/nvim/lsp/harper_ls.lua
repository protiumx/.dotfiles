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
  },
  root_markers = { '.git' },
}
