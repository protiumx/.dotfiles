return {
  'johmsalas/text-case.nvim',
  dependencies = { 'telescope.nvim' },
  config = function()
    require('telescope').load_extension('textcase')
  end,
  keys = {
    {
      'ga.',
      '<cmd>Telescope textcase normal_mode_quick_change theme=dropdown<CR>',
      desc = 'Show text case options',
    },
    {
      'gau',
      function()
        require('textcase').operator('to_upper_case')
      end,
      silent = true,
    },
    {
      'gal',
      function()
        require('textcase').operator('to_lower_case')
      end,
      silent = true,
    },
    {
      'gas',
      function()
        require('textcase').operator('to_snake_case')
      end,
      silent = true,
    },
    {
      'gad',
      function()
        require('textcase').operator('to_dash_case')
      end,
      silent = true,
    },
    {
      'gan',
      function()
        require('textcase').operator('to_constant_case')
      end,
      silent = true,
    },
    {
      'gaD',
      function()
        require('textcase').operator('to_dot_case')
      end,
      silent = true,
    },
    {
      'gac',
      function()
        require('textcase').operator('to_camel_case')
      end,
      silent = true,
    },
    {
      'gap',
      function()
        require('textcase').operator('to_pascal_case')
      end,
      silent = true,
    },
  },
  opts = {},
}
