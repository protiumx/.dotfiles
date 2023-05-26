local M = {}

function M.setup()
  local cmp = require('cmp')
  local compare = require('cmp.config.compare')
  local types = require('cmp.types')
  local luasnip = require('luasnip')

  local kind_icons = {
    Array = "[]",
    Boolean = " ",
    Calendar = "",
    Class = "ﴯ ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = "ﰠ ",
    File = " ",
    Folder = " ",
    Function = " ",
    Interface = " ",
    Keyword = " ",
    Method = " ",
    Module = " ",
    Null = "ﳠ",
    Number = " ",
    Object = " ",
    Operator = " ",
    Package = "",
    Property = "ﰠ ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = "פּ ",
    Table = "",
    Tag = "",
    Text = " ",
    TypeParameter = " ",
    Unit = "塞 ",
    Value = " ",
    Variable = " ",
    Watch = " ",
    Namespace = "",
  }

  cmp.setup({
    confirmation = {
      default_behavior = types.cmp.ConfirmBehavior.Replace,
    },
    completion = {
      keyword_length = 2,
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
        winhighlight = 'Normal:XMenu,FloatBorder:XMenuBorder,CursorLine:Visual,Search:None',
      }),
      documentation = cmp.config.window.bordered({
        winhighlight = 'Normal:XMenu,FloatBorder:XMenuBorder,CursorLine:Visual,Search:None',
        scrollbar = false,
      }),
    },
    sources = {
      {
        name = 'nvim_lsp',
        priority = 1000,
      },
      {
        name = 'luasnip',
        priority = 80,
      },
      {
        name = 'nvim_lua',
        priority = 20,
      },
      {
        name = 'buffer',
        max_item_count = 3,
        priority = 60,
      },
      {
        name = 'path',
        group_index = 1,
        priority = 40,
      },
      {
        name = 'spell',
        max_item_count = 3,
        group_index = 40,
      },
    },
    formatting = {
      format = function(_, vim_item)
        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
        vim_item.abbr = string.sub(vim_item.abbr, 1, 50)
        return vim_item
      end
    },
    sorting = {
      comparators = {
        compare.locality,
        compare.recently_used,
        compare.kind,
        compare.exact,
      },
    },
    preselect = cmp.PreselectMode.Item,
    mapping = cmp.mapping.preset.insert({
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ['<C-e>'] = cmp.mapping.close(),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-u>'] = cmp.mapping.scroll_docs(4),
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
      end, { 'i', 's' })
    }),
  })

  luasnip.config.set_config({
    region_check_events = 'InsertEnter',
    delete_check_events = 'InsertLeave'
  })

  require('luasnip.loaders.from_vscode').lazy_load()
end

return M
