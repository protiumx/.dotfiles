local ls = require('luasnip')
local rep = require('luasnip.extras').rep
local fmta = require('luasnip.extras.fmt').fmta
local fmt = require('luasnip.extras.fmt').fmt

local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local r = ls.restore_node
local sn = ls.snippet_node

local function in_test_file()
  local filename = vim.fn.expand('%:p')
  return vim.endswith(filename, '_test.go')
end

local snip_test_file = {
  show_condition = in_test_file,
  condition = in_test_file,
}

local function in_function()
  local current_node = vim.treesitter.get_node({ bufnr = 0 })
  if not current_node then
    return false
  end
  ---@type TSNode?
  local expr = current_node

  while expr do
    if expr:type() == 'function_declaration' or expr:type() == 'method_declaration' then
      return true
    end
    expr = expr:parent()
  end
  return false
end

local in_func = {
  show_condition = in_function,
  condition = in_function,
}

local function error_choices(index, text)
  return c(1, {
    sn(nil, { i(1, text) }),

    sn(nil, {
      t('fmt.Error("'),
      i(1, 'calling'),
      t(': %v", '),
      i(2, text),
      t(')'),
    }),
  })
end

local test_tpl = [[
func Test<>(t *testing.T) {
  tests := []struct{
    name string
    <>
  }{
    <>
  }

  for _, tt := range tests {
    t.Run(tt.name, func (t *testing.T) {
      <>
    })
  }
}]]

local bench_tpl = [[
func Benchmark<>(b *testing.B) {
  for i := 0; i << b.N; i++ {
    <>(<>)
  }
}
]]

return {
  setup = function()
    ls.add_snippets('go', {
      ls.s(
        { trig = 'tdt', name = 'Table driven test' },
        fmta(test_tpl, {
          i(1),
          i(2),
          i(3),
          i(4),
        }),
        snip_test_file
      ),

      ls.s(
        { trig = 'bench', name = 'bench test cases ', dscr = 'Create benchmark test' },
        fmta(bench_tpl, {
          ls.i(1, 'Fn'),
          rep(1),
          ls.i(2, 'args'),
        }),
        snip_test_file
      ),

      ls.s(
        { trig = 'noerr', name = 'Require No Error', dscr = 'Add a require.NoError call' },
        ls.c(1, {
          ls.sn(nil, fmt('require.NoError(t, {})', { ls.i(1, 'err') })),
          ls.sn(nil, fmt('require.NoError(t, {}, "{}")', { ls.i(1, 'err'), ls.i(2) })),
          ls.sn(
            nil,
            fmt('require.NoErrorf(t, {}, "{}", {})', { ls.i(1, 'err'), ls.i(2), ls.i(3) })
          ),
        }),
        snip_test_file
      ),

      -- errors.Wrap
      ls.s(
        { trig = 'erw', dscr = 'errors.Wrap' },
        fmt([[errors.Wrap({}, "{}")]], {
          ls.i(1, 'err'),
          ls.i(2, 'failed to'),
        })
      ),

      -- errors.Wrapf
      ls.s(
        { trig = 'erwf', dscr = 'errors.Wrapf' },
        fmt([[errors.Wrapf({}, "{}", {})]], {
          ls.i(1, 'err'),
          ls.i(2, 'failed %v'),
          ls.i(3, 'args'),
        })
      ),

      -- Nolint
      ls.s(
        { trig = 'nolt', dscr = 'ignore linter' },
        fmt([[//nolint:{} // {}]], {
          ls.i(1, 'staticcheck'),
          ls.i(2, 'Explain why'),
        })
      ),

      ls.s(
        {
          trig = 'ifce',
          name = 'if call err inline',
          dscr = 'Call a function and check the error inline',
        },
        fmt(
          [[
            if {err1} := {func}({args}); {err2} != nil {{
              return {err3}
            }}
            {finally}
          ]],
          {
            err1 = ls.i(1, { 'err' }),
            func = ls.i(2, { 'func' }),
            args = ls.i(3, { 'args' }),
            err2 = rep(1),
            err3 = d(2, function(args)
              return sn(nil, error_choices(nil, args[1][1]))
            end, 1),
            finally = ls.i(0),
          }
        ),
        {
          stored = {
            ['err'] = i(1, 'err'),
          },
          show_condition = in_function,
          condition = in_function,
        }
      ),

      ls.s(
        {
          trig = 'ifer',
          name = 'if err',
          dscr = 'Check an error',
        },
        fmt(
          [[
            if {err1} != nil {{
              return {err2}
            }}
            {finally}
          ]],
          {
            err1 = i(1, 'err'),
            err2 = d(2, function(args)
              return sn(nil, error_choices(nil, args[1][1]))
            end, 1),
            finally = ls.i(0),
          }
        ),
        {
          show_condition = in_function,
          condition = in_function,
        }
      ),

      ls.s(
        { trig = 'tysw', dscr = 'type switch' },
        fmt(
          [[
switch {} := {}.(type) {{
  case {}:
    {}
}}
{}]],
          {
            ls.i(1, 'v'),
            ls.i(2, 'i'),
            ls.i(3, 'int'),
            ls.i(4, '// TODO'),
            ls.i(0, ''),
          }
        ),
        in_func
      ),
    })
  end,
}
