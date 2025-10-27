return {
  'folke/flash.nvim',
  opts = {
    search = {
      enabled = false,
      multi_window = false,
      forward = true,
      wrap = true,
      mode = 'exact',
      -- behave like `incsearch`
      incremental = false,
      exclude = {
        'notify',
        'cmp_menu',
        'noice',
        'flash_prompt',
        function(win)
          -- exclude non-focusable windows
          return not vim.api.nvim_win_get_config(win).focusable
        end,
      },
      max_length = false, ---@type number|false
    },
    jump = {
      -- save location in the jumplist
      jumplist = false,
      -- jump position
      pos = 'start', ---@type "start" | "end" | "range"
      -- add pattern to search history
      history = false,
      -- add pattern to search register
      register = false,
      -- clear highlight after jump
      nohlsearch = true,
      -- automatically jump when there is only one match
      autojump = true,
    },
    modes = {
      char = {
        enabled = false,
      },
    },
    prompt = {
      enabled = false,
    },
  },
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    {
      'S',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump({
          search = { multi_window = true },
        })
      end,
      desc = 'Flash multi-window',
    },
    {
      '<Leader>S',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump({ continue = true })
      end,
      desc = 'Flash resume',
    },
  },
}
