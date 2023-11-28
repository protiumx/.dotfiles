local M = {}

function M.setup()
  local luasnip = require('luasnip')
  local s, sn = luasnip.snippet, luasnip.snippet_node
  local d = luasnip.dynamic_node
  local t = luasnip.text_node

  local function uuid()
    local id, _ = vim.fn.system('uuidgen'):gsub('\n', ''):lower()
    return id
  end

  local function date(fmt)
    return os.date(fmt)
  end

  luasnip.add_snippets('all', {
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
