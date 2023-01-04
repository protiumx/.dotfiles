local M = {}

function M.setup()
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
      'vim',
    },

    sync_install = false,
    auto_install = false,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      -- PaperColor looks better
      disable = { 'go' },
    },
  }
end

return M
