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

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

