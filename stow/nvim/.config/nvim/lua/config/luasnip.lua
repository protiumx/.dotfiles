local utils = require('config.utils')
local M = {}

local function date(fmt)
  return os.date(fmt)
end

function M.setup()
  local ls = require('luasnip')
  local fmt = require('luasnip.extras.fmt').fmt
  local extras = require('luasnip.extras')
  local rep = extras.rep
  local p = extras.partial
  local types = require('luasnip.util.types')

  local s = ls.snippet
  local sn = ls.snippet_node
  local d = ls.dynamic_node
  local i = ls.insert_node
  local t = ls.text_node

  ls.config.set_config({
    -- delete_check_events = 'InsertLeave',
    -- region_check_events = 'InsertEnter',
    update_events = { 'TextChanged', 'TextChangedI' },

    history = false,
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { '  ', 'Comment' } },
        },
      },
    },
  })

  require('luasnip.loaders.from_vscode').lazy_load()

  ls.add_snippets('lua', {
    s('reqf', fmt("local {} = require('{}')", { i(1, '_'), rep(1) })),
  })

  ls.add_snippets('all', {
    s({
      trig = 'uuid',
      name = 'UUIDv4',
    }, {
      p(utils.uuid),
    }),

    s({
      trig = 'iso',
      name = 'ISO',
      dscr = 'Now as ISO Date',
    }, {
      p(os.date, '%Y-%m-%dT%H:%M'),
    }),

    s({
      trig = 'epo',
      name = 'Epoch',
      dscr = 'Now as unix epoch',
    }, {
      p(os.date, '%s'),
    }),

    s({
      trig = 'build',
      name = 'Build date',
      dscr = 'Now as a build date time stamp',
    }, {
      p(os.date, '%Y%m%d%H%M'),
    }),
  })

  vim.keymap.set({ 'i', 's' }, '<M-n>', function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end)

  vim.keymap.set('i', '<M-p>', require('luasnip.extras.select_choice'))

  vim.keymap.set({ 'i', 's' }, '<C-l>', function()
    if ls.jumpable() then
      ls.jump(1)
    end
  end, { silent = true })

  vim.keymap.set({ 'i', 's' }, '<C-h>', function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, { silent = true })
  require('config.snippets.go').setup()
end

return M
