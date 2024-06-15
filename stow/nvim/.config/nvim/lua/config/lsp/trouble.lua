local M = {}

function M.config()
  require('trouble').setup({
    action_keys = { -- key mappings for actions in the trouble list
      -- map to {} to remove a mapping, for example:
      -- close = {},
      close = 'q', -- close the list
      cancel = '<esc>', -- cancel the preview and get back to your last window / buffer / cursor
      refresh = 'r', -- manually refresh
      jump = { '<cr>', '<tab>', '<2-leftmouse>' }, -- jump to the diagnostic or open / close folds
      open_split = { '<c-x>' }, -- open buffer in new split
      open_vsplit = { '<c-v>' }, -- open buffer in new vsplit
      open_tab = { '<c-t>' }, -- open buffer in new tab
      jump_close = { 'o' }, -- jump to the diagnostic and close the list
      toggle_mode = 'm', -- toggle between "workspace" and "document" diagnostics mode
      switch_severity = 's', -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
      toggle_preview = 'P', -- toggle auto_preview
      hover = 'K', -- opens a small popup with the full multiline message
      preview = 'p', -- preview the diagnostic location
      open_code_href = 'c', -- if present, open a URI with more information about the diagnostic error
      close_folds = { 'zM', 'zm' }, -- close all folds
      open_folds = { 'zR', 'zr' }, -- open all folds
      toggle_fold = { 'zA', 'za' }, -- toggle fold of current file
      previous = 'k', -- previous item
      next = 'j', -- next item
      help = '?', -- help menu
    },
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = { 'lsp_definitions' }, -- for the given modes, automatically jump if there is only a single result
    cycle_results = true, -- cycle item list when reaching beginning or end of list
    fold_closed = '', -- icon used for closed folds
    fold_open = '', -- icon used for open folds
    group = true, -- group results by file
    height = 10, -- height of the trouble list when position is top or bottom
    include_declaration = { 'lsp_references', 'lsp_implementations', 'lsp_definitions' }, -- for the given modes, include the declaration of the current symbol in the results
    indent_lines = true, -- add an indent guide below the fold icons
    mode = 'workspace_diagnostics', -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    multiline = true, -- render multi-line messages
    padding = true, -- add an extra new line on top of the list
    position = 'bottom', -- position of the list can be: bottom, top, left, right
    severity = vim.diagnostic.severity.WARN, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
    use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
    width = 50, -- width of the list when position is left or right
    win_config = { border = 'single' }, -- window configuration for floating windows. See |nvim_open_win()|.
  })
end

return M
