return function()
  local ts = require('nvim-treesitter')
  local fts = {
    'bash',
    'c',
    'cmake',
    'comment', -- For TODO, NOTE, etc
    'cpp',
    'gleam',
    'elixir',
    'eex',
    'heex',
    'go',
    'gomod',
    'javascript',
    'jsdoc',
    'json',
    'lua',
    'markdown',
    'markdown_inline',
    'ocaml',
    'proto',
    'python',
    'regex',
    'rust',
    'sql',
    'terraform',
    'toml',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',
  }
  ts.install(fts):wait(300000)

  vim.api.nvim_create_autocmd('FileType', {
    pattern = fts,
    callback = function()
      vim.treesitter.start()
    end,
  })
end
