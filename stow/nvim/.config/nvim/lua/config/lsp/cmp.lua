local M = {}

function M.setup()
  local cmp = require('cmp')
  local cmp_types = require('cmp.types')
  local compare = require('cmp.config.compare')
  local types = require('cmp.types')
  local luasnip = require('luasnip')

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
    Snippet = "  ",
    Struct = '  ',
    Text = '  ',
    TypeParameter = '  ',
    Unit = '  ',
    Value = '  ',
    Variable = '  ',
  }


  cmp.setup({
    enabled = function()
      local ftype = vim.api.nvim_buf_get_option(0, 'filetype')
      return ftype ~= 'sagarename' and ftype ~= 'TelescopePrompt'
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
      {
        name = 'nvim_lsp',
        priority = 1000,
        entry_filter = function(entry, _)
          return cmp_types.lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
        end
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
        keyword_length = 5,
        option = {
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
      {
        name = 'path',
        keyword_length = 3,
        priority = 40,
      },
      -- {
      --   name = 'spell',
      --   priority = 10,
      -- },
    },
    formatting = {
      fields = { "abbr", "kind" },
      format = function(_, item)
        item.kind = kind_icons[item.kind]
        item.abbr = string.sub(item.abbr, 1, 50)
        item.menu = ''
        return item
      end
    },
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,

        -- cmp.config.compare.kind,
        -- cmp.config.compare.score,
        cmp.config.compare.exact,
        cmp.config.compare.recently_used,
        cmp.config.compare.sort_text,
        -- cmp.config.compare.length,
        -- cmp.config.compare.order,
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
