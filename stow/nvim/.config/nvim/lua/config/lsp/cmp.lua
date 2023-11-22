local cmp_types = require('cmp.types')

local state = require('config.state')

local M = {}

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

  lua = {
    name = 'nvim_lua',
    priority = 20,
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

function M.setup()
  local cmp = require('cmp')
  local compare = require('cmp.config.compare')
  local types = require('cmp.types')
  local luasnip = require('luasnip')

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

      local ftype = vim.api.nvim_buf_get_option(0, 'filetype')
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
        luasnip.lsp_expand(args.body)
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
        compare.recently_used,
        compare.sort_text,
        -- compare.length,
        -- compare.order,
      },
    },
    preselect = cmp.PreselectMode.Item,
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
        elseif luasnip.expandable() then
          luasnip.expand()
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
      -- Jump to luasnip placeholders
      ['<C-j>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<C-k>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
  })

  luasnip.config.set_config({
    region_check_events = 'InsertEnter',
    delete_check_events = 'InsertLeave',
  })

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

  require('luasnip.loaders.from_vscode').lazy_load()
  require('config.lsp.snippets').setup()
end

return M
