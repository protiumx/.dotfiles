return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/neotest-go',
    'rouge8/neotest-rust',
  },
  cmd = 'Neotest',
  keys = {

    {
      '<Leader>tF',
      function()
        require('neotest').run.run(vim.fn.expand('%'))
      end,
      silent = true,
    },

    {
      '<Leader>tf',
      function()
        require('neotest').run.run()
      end,
      silent = true,
    },

    {
      '<Leader>tD',
      function()
        require('neotest').run.run(vim.fn.expand('%:p:h'))
      end,
      silent = true,
    },

    {
      '<Leader>tl',
      function()
        require('neotest').run.run_last()
      end,
      silent = true,
    },

    {
      '<Leader>tx',
      function()
        require('neotest').run.stop()
      end,
      silent = true,
    },

    {
      '<Leader>tS',
      function()
        require('neotest').summary.toggle({ enter = true })
      end,
      silent = true,
    },

    {
      '<Leader>to',
      function()
        require('neotest').output.open({ enter = true, last_run = true })
      end,
      silent = true,
    },

    {
      '<Leader>tO',
      function()
        require('neotest').output_panel.toggle()
      end,
      silent = true,
    },

    {
      '<Leader>tn',
      function()
        require('neotest').jump.next()
      end,
      silent = true,
    },

    {
      '<Leader>tN',
      function()
        require('neotest').jump.prev()
      end,
      silent = true,
    },

    {
      '<Leader>tw',
      function()
        require('neotest').watch.toggle(vim.fn.expand('%'))
      end,
      silent = true,
    },

    {
      ']t',
      function()
        require('neotest').jump.next({ status = 'failed' })
      end,
      silent = true,
    },

    {
      '[t',
      function()
        require('neotest').jump.prev({ status = 'failed' })
      end,
      silent = true,
    },
  },
  config = function()
    require('plugins.neotest.config')()
  end,
}
