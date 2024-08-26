local utils = require('config.utils')

local ISO_FORMAT = '%Y-%m-%dT%H:%M:%S'
local BUILD_DATE = '%Y%m%d%H%M'

return function()
  local ls = require('luasnip')
  local fmt = require('luasnip.extras.fmt').fmt
  local postfix = require('luasnip.extras.postfix').postfix
  local types = require('luasnip.util.types')

  local snippet = ls.snippet

  -- local d = ls.dynamic_node
  local f = ls.function_node
  local i = ls.insert_node
  -- local sn = ls.snippet_node
  -- local t = ls.text_node

  local extras = require('luasnip.extras')
  local rep = extras.rep
  local p = extras.partial

  ls.config.set_config({
    delete_check_events = 'InsertLeave',
    update_events = { 'TextChanged', 'TextChangedI' },

    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { '  ', 'Comment' } },
        },
      },
    },
  })

  require('luasnip.loaders.from_vscode').lazy_load({
    include = {
      'c',
      'cpp',
      'css',
      'docker',
      'eelixir',
      'elixir',
      'gleam',
      'go',
      'html',
      'javascript',
      'jsdoc',
      'license',
      'lua',
      'markdown',
      'make',
      'ocaml',
      'python',
      'rust',
      'shell',
      'sql',
    },
  })

  ls.add_snippets('lua', {
    snippet('reqf', fmt("local {} = require('{}')", { i(1, '_'), rep(1) })),
  })

  ls.add_snippets('all', {
    snippet({
      trig = 'uuid',
      name = 'UUIDv4',
    }, {
      p(utils.uuid),
    }),

    snippet({
      trig = 'uid',
      name = 'UID',
    }, {
      p(utils.uid),
    }),

    snippet({
      trig = 'iso',
      name = 'ISO',
      dscr = 'Now as ISO Date',
    }, {
      p(os.date, ISO_FORMAT),
    }),

    snippet({
      trig = 'epo',
      name = 'Epoch',
      dscr = 'Now as unix epoch',
    }, {
      p(os.date, '%s'),
    }),

    snippet({
      trig = 'build',
      name = 'Build date',
      dscr = 'Now as a build date time stamp',
    }, {
      p(os.date, BUILD_DATE),
    }),

    postfix({
      trig = '.toiso',
      name = 'epoch to ISO',
      match_pattern = '%d+',
      docTrig = '0',
    }, {
      f(function(_, parent)
        local ret = ''
        if #parent.snippet.env.POSTFIX_MATCH < 9 then
          ret = os.date(ISO_FORMAT)
        else
          ret = os.date(ISO_FORMAT, tonumber(parent.snippet.env.POSTFIX_MATCH))
        end
        return ret
      end, {}),
    }),
  }, {})

  require('config.snippets.go').setup()
end
