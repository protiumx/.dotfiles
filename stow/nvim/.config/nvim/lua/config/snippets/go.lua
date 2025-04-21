-- from https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/snips/ft/go.lua

local ls = require('luasnip')
local rep = require('luasnip.extras').rep
local fmta = require('luasnip.extras.fmt').fmta
local fmt = require('luasnip.extras.fmt').fmt

local sn = ls.snippet_node
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node

local get_node_text = vim.treesitter.get_node_text

local function in_test_file()
  local filename = vim.fn.expand('%:p')
  return vim.endswith(filename, '_test.go')
end

local snip_test_file = {
  show_condition = in_test_file,
  condition = in_test_file,
}

local function error_choices(info)
  return c(info.index, {
    t(info.err_name),

    fmt('fmt.Error("{}: %v", {})', {
      i(1, 'fail'),
      t(info.err_name),
    }),

    fmt('errors.Wrap({}, "{}")', {
      t(info.err_name),
      i(1, 'fail'),
    }),
  })
end

local transforms = {
  int = function(_, _)
    return t('0')
  end,

  bool = function(_, _)
    return t('false')
  end,

  string = function(_, _)
    return t([[""]])
  end,

  error = function(_, info)
    if info then
      info.index = info.index + 1

      return error_choices(info)
    else
      return t('err')
    end
  end,

  -- Types with a "*" mean they are pointers, so return nil
  [function(text)
    return string.find(text, '*', 1, true) ~= nil
  end] = function(_, _)
    return t('nil')
  end,
}

local transform = function(text, info)
  local condition_matches = function(condition, ...)
    if type(condition) == 'string' then
      return condition == text
    else
      return condition(...)
    end
  end

  for condition, result in pairs(transforms) do
    if condition_matches(condition, text, info) then
      return result(text, info)
    end
  end

  return t(text)
end

local handlers = {
  parameter_list = function(node, info)
    local result = {}

    local count = node:named_child_count()
    for idx = 0, count - 1 do
      local matching_node = node:named_child(idx)
      local type_node = matching_node:field('type')[1]
      table.insert(result, transform(get_node_text(type_node, 0), info))
      if idx ~= count - 1 then
        table.insert(result, t({ ', ' }))
      end
    end

    return result
  end,

  type_identifier = function(node, info)
    local text = get_node_text(node, 0)
    return { transform(text, info) }
  end,
}

local function_node_types = {
  function_declaration = true,
  method_declaration = true,
  func_literal = true,
}

local function go_result_type(info)
  local ts_locals = require('nvim-treesitter.locals')
  local ts_utils = require('nvim-treesitter.ts_utils')

  local cursor_node = ts_utils.get_node_at_cursor()
  local scope = ts_locals.get_scope_tree(cursor_node, 0)

  local function_node
  for _, v in ipairs(scope) do
    if function_node_types[v:type()] then
      function_node = v
      break
    end
  end

  if not function_node then
    -- not inside of a function
    return t('')
  end

  local query = vim.treesitter.query.parse(
    'go',
    [[
      [
        (method_declaration result: (_) @id)
        (function_declaration result: (_) @id)
        (func_literal result: (_) @id)
      ]
    ]]
  )
  for _, node in query:iter_captures(function_node, 0) do
    if handlers[node:type()] then
      return handlers[node:type()](node, info)
    end
  end

  return t('')
end

local go_ret_vals = function(args)
  return sn(
    nil,
    go_result_type({
      index = 0,
      err_name = args[1][1],
      func_name = args[2][1],
    })
  )
end

local efi_tpl = [[
<val>, <err> := <func>(<args>)
if <err_r> != nil {
  return <ret>
}
<finish>]]

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

local call_tpl = [[
<> := <>
if err != nil {
  return <>
}
]]

return {
  setup = function()
    ls.add_snippets('go', {
      ls.s(
        'efi',
        fmta(efi_tpl, {
          val = i(1),
          err = i(2, 'err'),
          func = i(3),
          args = i(4),
          err_r = rep(2),
          ret = d(5, go_ret_vals, { 2, 3 }),
          finish = i(0),
        })
      ),

      ls.s(
        'tft',
        fmta(test_tpl, {
          i(1),
          i(2),
          i(3),
          i(4),
        }),
        snip_test_file
      ),

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
    })
  end,
}
