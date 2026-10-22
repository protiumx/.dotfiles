-- https://github.com/artempyanykh/marksman

---@type vim.lsp.Config
return {
  cmd = { 'marksman', 'server' },
  filetypes = { 'markdown' },
  root_markers = { '.marksman.toml', '.git' },
}
