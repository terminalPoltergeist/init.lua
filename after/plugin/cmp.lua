local cmp = require('cmp')

cmp.setup({
    -- formatting = {
    --     format = require('lspkind').cmp_format({
    --       mode = 'symbol', -- show only symbol annotations
    --       maxwidth = {
    --         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    --         -- can also be a function to dynamically calculate max width such as
    --         -- menu = function() return math.floor(0.45 * vim.o.columns) end,
    --         menu = 50, -- leading text (labelDetails)
    --         abbr = 50, -- actual suggestion item
    --       },
    --       ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    --       show_labelDetails = true, -- show labelDetails in menu. Disabled by default

    --       -- The function below will be called before any actual modifications from lspkind
    --       -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
    --       before = function (entry, vim_item)
    --         return vim_item
    --       end
    --     })
    -- },
    sources = {
        {name = 'nvim_lsp'},
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "marksman" },
    },
    snippet = {
        expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            vim.snippet.expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        -- elseif luasnip.expand_or_jumpable() then
          -- luasnip.expand_or_jump()
        else
          fallback()
        end
      end, {"i", "s"}),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        -- elseif luasnip.jumpable(-1) then
          -- luasnip.jump(-1)
        else
          fallback()
        end
      end, {"i", "s"}),
      ['<C-k>'] = cmp.mapping.scroll_docs(-4),
      ['<C-j>'] = cmp.mapping.scroll_docs(4),
      ['<C-a>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    window = {
        documentation = {
            max_height = 15,
            max_width = 60,
        },
    }
})

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
})


local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.tab_complete = function()
    if vim.fn.call("vsnip#available", {1}) == 1 then
		return t("<Plug>(vsnip-expand-or-jump)")
    elseif vim.fn.pumvisible() then
		return t("<C-n>")
    else
        return t("<Tab>")
    end
end

vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.tab_complete()", {expr = true})
