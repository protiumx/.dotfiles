local M = {}

function M.setup()
  -- get neotest namespace (api call creates or returns namespace)
  local neotest_ns = vim.api.nvim_create_namespace("neotest")
  vim.diagnostic.config({
    virtual_text = {
      format = function(diagnostic)
        local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
        return message
      end,
    },
  }, neotest_ns)

  local neotest = require("neotest")
  neotest.setup({
    adapters = {
      require("neotest-go"),
      require("neotest-rust"),
    },
    summary = {
      animated = true,
      enabled = true,
      expand_errors = true,
      follow = true,
      mappings = {
        attach = "a",
        clear_marked = "M",
        clear_target = "T",
        debug = "d",
        debug_marked = "D",
        expand = { "<CR>", "<2-LeftMouse>" },
        expand_all = "e",
        jumpto = "<C-o>",
        mark = "m",
        next_failed = "J",
        output = "o",
        prev_failed = "K",
        run = "r",
        run_marked = "R",
        short = "O",
        stop = "x",
        target = "t",
        watch = "w"
      },
    },
    icons = {
      child_indent = "│",
      child_prefix = "├",
      collapsed = "─",
      expanded = "╮",
      failed = "",
      final_child_indent = " ",
      final_child_prefix = "╰",
      non_collapsible = "─",
      passed = "",
      running = "",
      running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
      skipped = "",
      unknown = "",
      watching = ""
    },
    floating = {
      border = "rounded",
      max_height = 0.6,
      max_width = 0.6,
    },
  })

  vim.keymap.set('n', '<Leader>tF', function()
    neotest.run.run(vim.fn.expand('%'))
  end, { silent = true })

  vim.keymap.set('n', '<Leader>tf', function()
    neotest.run.run()
  end, { silent = true })

  vim.keymap.set('n', '<Leader>tS', function()
    neotest.summary.toggle()
  end, { silent = true })

  vim.keymap.set('n', '<Leader>tn', function()
    neotest.jump.next()
  end, { silent = true })

  vim.keymap.set('n', '<Leader>tN', function()
    neotest.jump.prev()
  end, { silent = true })
end

return M
