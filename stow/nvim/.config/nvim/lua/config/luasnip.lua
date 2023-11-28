local M = {}

local function date(fmt)
  return os.date(fmt)
end

function M.setup()
  local ls = require('luasnip')
  local fmt = require('luasnip.extras.fmt').fmt
  local rep = require('luasnip.extras').rep

  local s = ls.snippet
  local sn = ls.snippet_node
  local d = ls.dynamic_node
  local i = ls.insert_node
  local t = ls.text_node

  ls.config.set_config({
    delete_check_events = 'InsertLeave',
    region_check_events = 'InsertEnter',
    -- update dynamic nodes while typing
    update_events = { 'TextChanged', 'TextChangedI' },
  })

  require('luasnip.loaders.from_vscode').lazy_load()

  local function uuid()
    local id, _ = vim.fn.system('uuidgen'):gsub('\n', ''):lower()
    return id
  end

  ls.add_snippets('lua', {
    s('reqf', fmt("local {} = require('{}')", { i(1, '_'), rep(1) })),
  })

  ls.add_snippets('all', {
    s({
      trig = 'uuid',
      name = 'UUID',
      dscr = 'Generate a unique UUID',
    }, {
      d(1, function()
        return sn(nil, t(uuid()))
      end),
    }),

    s({
      trig = 'iso',
      name = 'ISO',
      dscr = 'Now as ISO Date',
    }, {
      d(1, function()
        return sn(nil, t(date('%Y-%m-%dT%H:%M')))
      end),
    }),

    s({
      trig = 'epo',
      name = 'Epoch',
      dscr = 'Now as unix epoch',
    }, {
      d(1, function()
        return sn(nil, t(date('%s')))
      end),
    }),

    s({
      trig = 'build',
      name = 'Build date',
      dscr = 'Now as a build date time stamp',
    }, {
      d(1, function()
        return sn(nil, t(date('%Y%m%d%H%M')))
      end),
    }),
  })
end

return M
