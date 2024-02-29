local icons = require('config.icons').lsp

local M = {}

function M.setup()
  vim.fn.sign_define('DiagnosticSignError', { text = icons.error, texthl = 'DiagnosticSignError' })
  vim.fn.sign_define('DiagnosticSignWarn', { text = icons.warn, texthl = 'DiagnosticSignWarn' })
  vim.fn.sign_define('DiagnosticSignInfo', { text = icons.info, texthl = 'DiagnosticSignInfo' })
  vim.fn.sign_define('DiagnosticSignHint', { text = icons.hint, texthl = 'DiagnosticSignHint' })

  vim.lsp.set_log_level('off')

  require('config.lsp.mason').setup()
  require('config.lsp.saga').setup()
  require('fidget').setup({
    -- Options related to LSP progress subsystem
    progress = {
      -- Options related to how LSP progress messages are displayed as notifications
      display = {
        render_limit = 5, -- How many LSP messages to show at once
        done_ttl = 3, -- How long a message should persist after completion
        done_icon = '', -- Icon shown when all LSP progress tasks are complete
        done_style = 'Constant', -- Highlight group for completed LSP tasks
        progress_ttl = math.huge, -- How long a message should persist when in progress
        -- Icon shown when LSP progress tasks are in progress
        progress_icon = { pattern = 'dots', period = 1 },
        -- Highlight group for in-progress LSP tasks
        progress_style = 'WarningMsg',
        group_style = 'Title', -- Highlight group for group name (LSP server name)
        icon_style = 'Question', -- Highlight group for group icons
        priority = 30, -- Ordering priority for LSP notification group
        skip_history = true, -- Whether progress notifications should be omitted from history
        overrides = { -- Override options from the default notification config
          rust_analyzer = { name = 'rust-analyzer' },
        },
      },
    },
    -- Options related to notification subsystem
    notification = {
      filter = vim.log.levels.INFO, -- Minimum notifications level
      view = {
        stack_upwards = false, -- Display notification items from bottom to top
        icon_separator = ' ', -- Separator between group name and icon
        group_separator = '---', -- Separator between notification groups
        -- Highlight group used for group separator
        group_separator_hl = 'Comment',
      },

      -- Options related to the notification window and buffer
      window = {
        normal_hl = 'Comment', -- Base highlight group in the notification window
        winblend = 0, -- Background color opacity in the notification window
        border = 'none', -- Border around the notification window
        zindex = 45, -- Stacking priority of the notification window
        max_width = 0, -- Maximum width of the notification window
        max_height = 0, -- Maximum height of the notification window
        x_padding = 1, -- Padding from right edge of window boundary
        y_padding = 0, -- Padding from bottom edge of window boundary
        align = 'top', -- How to align the notification window
        relative = 'editor', -- What the notification window position is relative to
      },
    },
  })

  -- NOTE: noice.nvim sets these 2 handlers
  -- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  --   vim.lsp.handlers.hover,
  --   {
  --     border = 'single',
  --   }
  -- )

  -- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  --   vim.lsp.handlers.signature_help,
  --   {
  --     border = 'single',
  --   }
  -- )
  --

  vim.diagnostic.config({
    virtual_text = {
      spacing = 1,
      format = function(_)
        -- just show the sign
        return ''
      end,
    },
    float = {
      focusable = true,
      source = true,
      boder = 'single',
      header = '',
      prefix = '',
      max_width = 100,
      zindex = 40,
    },
    underline = false,
    severity_sort = true,
    signs = false,
    update_in_insert = true,
  })
end

return M
