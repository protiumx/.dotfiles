return {
  'sindrets/diffview.nvim',
  cond = function()
    return vim.fn.isdirectory(vim.fn.getcwd() .. '/.git/')
  end,
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<M-D>', '<cmd>DiffviewOpen<CR>', desc = 'Open Diffview HEAD', silent = true },
    {
      '<M-H>',
      '<cmd>DiffviewFileHistory %<CR>',
      desc = 'Open Diffview history current file',
      silent = true,
    },
  },
  config = function()
    require('plugins.diffview.config')()
  end,
}
