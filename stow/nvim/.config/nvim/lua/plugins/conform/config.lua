return function()
  local conform = require('conform')
  conform.setup({
    format_on_save = {
      timeout_ms = 2000,
      lsp_fallback = true,
    },
    formatters = {
      goimports = {
        prepend_args = { '-local', 'go.crwd.dev,github.com/CrowdStrike' },
      },
    },
    formatters_by_ft = {
      bash = { 'shfmt' },
      go = { 'goimports', 'gofumpt' },
      html = { 'prettier' },
      javascript = { 'prettier' },
      json = { 'prettier' },
      lua = { 'stylua' },
      ocaml = { 'ocamlformat' },
      proto = { 'buf' },
      python = { 'black' },
      sh = { 'shfmt' },
      zsh = { 'shfmt' },
    },
  })

  vim.api.nvim_create_user_command('Format', function(args)
    local range = nil
    if args.count ~= -1 then
      local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
      range = {
        start = { args.line1, 0 },
        ['end'] = { args.line2, end_line:len() },
      }
    end
    conform.format({ async = true, lsp_fallback = true, range = range })
  end, { range = true })

  vim.api.nvim_create_user_command('FormatDisable', function(args)
    if args.bang then
      -- FormatDisable! will disable formatting just for this buffer
      vim.b.disable_autoformat = true
    else
      vim.g.disable_autoformat = true
    end
  end, {
    desc = 'Disable autoformat-on-save',
    bang = true,
  })

  vim.api.nvim_create_user_command('FormatEnable', function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
  end, {
    desc = 'Re-enable autoformat-on-save',
  })
end
