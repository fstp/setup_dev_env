-- Auto-completion / Snippets
return {
  -- https://github.com/hrsh7th/nvim-cmp
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Snippet engine & associated nvim-cmp source
    -- https://github.com/L3MON4D3/LuaSnip
    'L3MON4D3/LuaSnip',
    -- https://github.com/saadparwaiz1/cmp_luasnip
    'saadparwaiz1/cmp_luasnip',

    -- LSP completion capabilities
    -- https://github.com/hrsh7th/cmp-nvim-lsp
    'hrsh7th/cmp-nvim-lsp',

    -- Additional user-friendly snippets
    -- https://github.com/rafamadriz/friendly-snippets
    'rafamadriz/friendly-snippets',
    -- https://github.com/hrsh7th/cmp-buffer
    'hrsh7th/cmp-buffer',
    -- https://github.com/hrsh7th/cmp-path
    'hrsh7th/cmp-path',
    -- https://github.com/hrsh7th/cmp-cmdline
    'hrsh7th/cmp-cmdline',

    -- Tailwind CSS tools
    { 'luckasRanarison/tailwind-tools.nvim' },
    { 'onsails/lspkind-nvim' }, -- Highlighting colors
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')

    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup({})

    cmp.setup({
      formatting = {
        format = require("lspkind").cmp_format({
          before = require("tailwind-tools.cmp").lspkind_format
        }),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
        ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),    -- scroll backward
        ['<C-f>'] = cmp.mapping.scroll_docs(4),     -- scroll forward
        ['<C-u>'] = cmp.mapping.abort(),            -- abort selection
        ['<C-Space>'] = cmp.mapping.complete {},    -- show completion suggestions
        ['<C-l>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        -- Tab through suggestions or when a snippet is active, tab to the next argument
        ['<Tab>'] = cmp.mapping(function(fallback)
          -- if cmp.visible() then
          --   cmp.select_next_item()
          --elseif luasnip.expand_or_locally_jumpable() then
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        -- Tab backwards through suggestions or when a snippet is active, tab to the next argument
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          -- if cmp.visible() then
          --   cmp.select_prev_item()
          -- elseif luasnip.locally_jumpable(-1) then
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = cmp.config.sources({
        -- { name = "copilot", max_item_count = 4 }, -- copilot
        -- { name = "nvim_lsp", max_item_count = 15 }, -- lsp
        -- { name = "luasnip", max_item_count = 15 }, -- snippets
        -- { name = "buffer", max_item_count = 4 }, -- text within current buffer
        -- { name = "path", max_item_count = 4 }, -- file system paths
        { name = "nvim_lsp" }, -- lsp
        { name = "copilot" }, -- copilot
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
        -- { name = "copilot",  max_item_count = 10 }, -- copilot
        -- { name = "nvim_lsp", max_item_count = 10 }, -- lsp
        -- { name = "luasnip",  max_item_count = 4 },  -- snippets
        -- { name = "buffer",   max_item_count = 4 },  -- text within current buffer
        -- { name = "path",     max_item_count = 4 },  -- file system paths
      }),
      window = {
        -- Add borders to completions popups
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })
  end,
}
