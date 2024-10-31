return function()
  -- get neotest namespace (api call creates or returns namespace)
  local neotest_ns = vim.api.nvim_create_namespace('neotest')
  vim.diagnostic.config({
    virtual_text = {
      format = function(diagnostic)
        local message =
          diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
        return message
      end,
    },
  }, neotest_ns)

  local neotest = require('neotest')
  neotest.setup({
    adapters = {
      require('neotest-go'),
      require('neotest-rust'),
    },
    summary = {
      animated = true,
      enabled = true,
      expand_errors = true,
      follow = true,
      mappings = {
        attach = 'a',
        clear_marked = 'M',
        clear_target = 'T',
        debug = 'd',
        debug_marked = 'D',
        expand = { '<CR>', '<2-LeftMouse>' },
        expand_all = 'e',
        jumpto = '<C-o>',
        mark = 'm',
        next_failed = 'J',
        output = 'O',
        prev_failed = 'K',
        run = 'r',
        run_marked = 'R',
        short = 'o',
        stop = 'x',
        target = 't',
        watch = 'w',
      },
    },
    output = {
      enabled = true,
      open_on_run = true,
    },
    output_panel = {
      enabled = true,
      open = 'vertical topleft split',
    },
    icons = {
      child_indent = '│',
      child_prefix = '├',
      collapsed = '─',
      expanded = '╮',
      failed = '',
      final_child_indent = ' ',
      final_child_prefix = '╰',
      non_collapsible = '─',
      passed = '',
      running = '',
      running_animated = { '/', '|', '\\', '-', '/', '|', '\\', '-' },
      skipped = '',
      unknown = '',
      watching = '',
    },
    status = {
      enabled = true,
      signs = true,
      virtual_text = false,
    },
    floating = {
      border = 'rounded',
      max_height = 0.6,
      max_width = 0.8,
    },
  })
end
