local cmp_types = require('cmp.types')

local state = require('config.state')

local kind_icons = {
  Class = '  ',
  Color = '  ',
  Constant = '  ',
  Constructor = '  ',
  Enum = '  ',
  EnumMember = '  ',
  Event = '  ',
  Field = '  ',
  File = '  ',
  Folder = '  ',
  Function = '  ',
  Interface = '  ',
  Keyword = '  ',
  Method = '  ',
  Module = '  ',
  Operator = '  ',
  Property = '  ',
  Reference = '  ',
  Snippet = '  ',
  Struct = '  ',
  Text = '  ',
  TypeParameter = '  ',
  Unit = '  ',
  Value = '  ',
  Variable = '  ',
}

local sources = {
  lsp = {
    name = 'nvim_lsp',
    priority = 1000,
    entry_filter = function(entry, _)
      return cmp_types.lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
    end,
  },

  snippets = {
    name = 'luasnip',
    priority = 80,
  },

  buffer = {
    name = 'buffer',
    group_index = 2,
    keyword_length = 3,
    option = {
      -- Only buffers in the current tab
      get_bufnrs = function()
        local bufs = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          bufs[vim.api.nvim_win_get_buf(win)] = true
        end
        return vim.tbl_keys(bufs)
      end,
    },
    priority = 60,
  },

  path = {
    name = 'path',
    keyword_length = 3,
    group_index = 2,
    priority = 40,
  },

  spell = {
    name = 'spell',
    priority = 10,
  },
}

return function()
  local cmp = require('cmp')
  local compare = require('cmp.config.compare')
  local types = require('cmp.types')

  local excluded_ftypes = {
    sagarename = true,
    TelescopePrompt = true,
    ['dap-repl'] = true,
    dapui_watches = true,
  }

  cmp.setup({
    enabled = function()
      if state.get('quiet') then
        return false
      end

      local ftype = vim.api.nvim_get_option_value('filetype', { buf = 0 })
      return not excluded_ftypes[ftype]
    end,

    confirmation = {
      default_behavior = types.cmp.ConfirmBehavior.Replace,
    },

    completion = {
      completeopt = 'menu, menuone',
    },

    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },

    window = {
      completion = cmp.config.window.bordered({
        border = 'none',
        scrollbar = false,
        winhighlight = 'Normal:NormalFloat,CursorLine:Visual,Search:None',
      }),

      documentation = cmp.config.window.bordered({
        winhighlight = 'Normal:NormalFloat,CursorLine:Visual,Search:None',
        scrollbar = true,
      }),
    },

    perfomance = {
      throttle = 150,
    },

    sources = {
      sources.lsp,
      sources.snippets,
      sources.lua,
      sources.buffer,
      sources.path,
    },

    formatting = {
      fields = { 'abbr', 'kind' },
      format = function(_, item)
        item.kind = kind_icons[item.kind]
        item.abbr = string.sub(item.abbr, 1, 50)
        item.menu = ''
        return item
      end,
    },

    sorting = {
      comparators = {
        compare.offset,
        compare.exact,
        -- compare.kind,
        -- compare.score,
        -- compare.exact,
        compare.sort_text,
        compare.recently_used,
        -- compare.length,
        -- compare.order,
      },
    },

    preselect = cmp.PreselectMode.Item,

    view = {
      entries = {
        follow_cursor = true,
      },
    },

    mapping = cmp.mapping.preset.insert({
      ['<CR>'] = cmp.mapping.confirm({
        select = true,
      }),
      ['<C-e>'] = cmp.mapping.close(),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        -- elseif luasnip.expand_or_locally_jumpable() then
        --   luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<C-k>'] = cmp.mapping(function(fallback)
        local luasnip = require('luasnip')
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jumpable()
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
  })

  vim.keymap.set('i', '<M-:>', function()
    cmp.complete({
      config = {
        sources = {
          { name = 'luasnip' },
        },
      },
    })
  end)

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('cmp-ft', { clear = true }),
    pattern = { 'markdown' },
    callback = function()
      require('cmp').setup.buffer({
        sources = {
          sources.spell,
          sources.snippets,
          sources.path,
          sources.buffer,
        },
      })
    end,
  })
end
