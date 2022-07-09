  local cmp = require 'cmp'

  local cmp_kinds = {
    Text = '  ',
    Method = '  ',
    Function = '  ',
    Constructor = '  ',
    Field = '  ',
    Variable = '  ',
    Class = '  ',
    Interface = '  ',
    Module = '  ',
    Property = '  ',
    Unit = '  ',
    Value = '  ',
    Enum = '  ',
    Keyword = '  ',
    Snippet = '  ',
    Color = '  ',
    File = '  ',
    Reference = '  ',
    Folder = '  ',
    EnumMember = '  ',
    Constant = '  ',
    Struct = '  ',
    Event = '  ',
    Operator = '  ',
    TypeParameter = '  ',
  }

  cmp.setup({
    snippet = {
      expand = function(args) require('luasnip').lsp_expand(args.body) end,
    },
    mapping = cmp.mapping.preset.insert({
      -- ['<C-Up>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
      -- ['<C-Down>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
      ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
      ['<C-e>'] = cmp.mapping {i = cmp.mapping.abort(), c = cmp.mapping.close()},
      ['<CR>'] = cmp.mapping.confirm {select = true},
      ['<Tab>'] = cmp.mapping(function(fallback)
        -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if not entry then
            cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
          else
            cmp.confirm()
          end
        else
          fallback()
        end
      end, {'i', 's', 'c'}),
    }),
    sources = cmp.config.sources({
      {name = 'nvim_lua'}, {name = 'nvim_lsp'}, {name = 'path'},
    }, {{name = 'buffer'}}),
    formatting = {
      format = function(_, vim_item)
        vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
        return vim_item
      end,
    },
  })

  -- Use buffer source for `/`.
  cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

  -- Use cmdline & path source for ':'.
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}}),
  })
