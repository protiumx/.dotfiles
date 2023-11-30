local ls = require('luasnip')
local rep = require('luasnip.extras').rep
local fmta = require('luasnip.extras.fmt').fmta
local fmt = require('luasnip.extras.fmt').fmt

local s = ls.s
local sn = ls.snippet_node
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node

local snip = [[
<val>, <err> := <func>(<args>)
if <err_r> != nil {
  return <ret>
}
<finish>
]]

return {
  setup = function()
    ls.add_snippets('go', {
      s(
        'efi',
        fmta(snip, {
          val = i(1),
          err = i(2, 'err'),
          func = i(3),
          args = i(4),
          err_r = rep(2),
          ret = d(5, function(args)
            local err = (args and args[1] and args[1][1]) or ''
            return sn(
              nil,
              c(1, {
                t(err),

                fmt('fmt.Error("{}: %v", {})', {
                  i(1, 'failed'),
                  t(err),
                }),

                fmt('errors.Wrap({}, "{}")', {
                  t(err),
                  i(1, 'failed'),
                }),
              })
            )
          end, { 2 }),
          finish = i(0),
        })
      ),
    })
  end,
}
