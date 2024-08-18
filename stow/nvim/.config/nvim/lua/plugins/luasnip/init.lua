return {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  keys = {
    {
      '<M-n>',
      function()
        local ls = require('luasnip')
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end,
      mode = { 'i', 's' },
    },

    {
      '<M-p>',
      function()
        require('luasnip.extras.select_choice')()
      end,
      mode = { 'i' },
    },

    {
      '<C-l>',
      function()
        local ls = require('luasnip')
        if ls.jumpable() then
          ls.jump(1)
        end
      end,
      mode = { 'i', 's' },
      silent = true,
    },

    {
      '<C-h>',
      function()
        local ls = require('luasnip')
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end,
      mode = { 'i', 's' },
      silent = true,
    },

    {
      '<C-x>',
      function()
        require('luasnip').expand({
          jump_into_func = function(snip)
            return snip:jump_into(2)
          end,
        })
      end,
      mode = { 'i' },
      silent = true,
    },
  },
  config = function()
    require('plugins.luasnip.config')()
  end,
}
