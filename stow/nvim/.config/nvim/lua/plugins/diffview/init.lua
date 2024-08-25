return {
  'sindrets/diffview.nvim',
  cond = function()
    return vim.fn.isdirectory(vim.fn.getcwd() .. '/.git/')
  end,
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<M-.>', '<cmd>DiffviewOpen<CR>', desc = 'Diffview HEAD', silent = true },
    {
      '<M-H>',
      '<cmd>DiffviewFileHistory %<CR>',
      desc = 'Diffview file history',
      silent = true,
    },
  },
  config = function()
    require('plugins.diffview.config')()
  end,
}
