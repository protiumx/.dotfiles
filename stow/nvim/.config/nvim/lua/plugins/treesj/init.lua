return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter' },
  opts = {
    use_default_keymaps = false,
    check_syntax_error = true,
    max_join_length = 10,
    -- hold|start|end:
    -- hold - cursor follows the node/place on which it was called
    -- start - cursor jumps to the first symbol of the node being formatted
    -- end - cursor jumps to the last symbol of the node being formatted
    cursor_behavior = 'hold',
    -- Notify about possible problems or not
    notify = true,
    -- Use `dot` for repeat action
    dot_repeat = true,
  },
  keys = {
    {
      '<Leader>ts',
      function()
        require('treesj').split()
      end,
      desc = 'TS Split lines',
      silent = true,
    },
    {
      '<Leader>tj',
      function()
        require('treesj').join()
      end,
      desc = 'TS Join lines',
      silent = true,
    },
  },
}
