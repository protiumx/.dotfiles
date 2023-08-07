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
  })

  vim.keymap.set('n', '<Leader>tF', function()
    neotest.run.run(vim.fn.expand('%'))
  end, { silent = true })
  vim.keymap.set('n', '<Leader>tF', function()
    neotest.run.run(vim.fn.expand())
  end, { silent = true })
end

return M
