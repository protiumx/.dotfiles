local M = {}

function M.setup()
  local luasnip = require('luasnip')
  local s, sn = luasnip.snippet, luasnip.snippet_node
  local i, d = luasnip.insert_node, luasnip.dynamic_node

  local function uuid()
    local id, _ = vim.fn.system('uuidgen'):gsub('\n', ''):lower()
    return id
  end

  luasnip.add_snippets('all', {
    s({
      trig = 'uuid',
      name = 'UUID',
      dscr = 'Generate a unique UUID',
    }, {
      d(1, function()
        return sn(nil, i(1, uuid()))
      end),
    }),
  })
end

return M
