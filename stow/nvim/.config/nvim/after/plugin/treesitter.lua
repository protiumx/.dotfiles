require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    'help',
    'javascript',
    'go',
    'typescript',
    'c',
    'cpp',
    'lua',
    'rust',
  },
  sync_install = false,
  auto_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    -- PaperColor looks way better
    disable = { 'go' },
  },
}
