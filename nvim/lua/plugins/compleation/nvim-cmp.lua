-- return {
--   {
--     "hrsh7th/cmp-nvim-lsp",
--   },
--
--   {
--     "L3MON4D3/LuaSnip",
--     dependencies = {
--       "saadparwaiz1/cmp_luasnip",
--       "rafamadriz/friendly-snippets",
--     },
--   },
--
--   {
--     "hrsh7th/nvim-cmp",
--     config = function()
--       local cmp = require("cmp")
--       require("luasnip.loaders.from_vscode").lazy_load()
--
--       local cmp_autopairs = require("nvim-autopairs.completion.cmp")
--       cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
--
--       cmp.setup({
--         snippet = {
--           expand = function(args)
--             require("luasnip").lsp_expand(args.body)
--           end,
--         },
--
--         window = {
--           completion = cmp.config.window.bordered(),
--           documentation = cmp.config.window.bordered(),
--         },
--
--         mapping = cmp.mapping.preset.insert({
--           ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--           ["<C-f>"] = cmp.mapping.scroll_docs(4),
--           ["<C-Space>"] = cmp.mapping.complete(),
--           ["<C-e>"] = cmp.mapping.abort(),
--           ["<CR>"] = cmp.mapping.confirm({ select = true }),
--   ["<Tab>"] = function(fallback)
--     if cmp.visible() then
--       cmp.select_next_item()
--     elseif luasnip.expand_or_jumpable() then
--       luasnip.expand_or_jump()
--     else
--       fallback()
--     end
--   end,
--   ["<S-Tab>"] = function(fallback)
--     if cmp.visible() then
--       cmp.select_prev_item()
--     elseif luasnip.jumpable(-1) then
--       luasnip.jump(-1)
--     else
--       fallback()
--     end
--   end,        }),
--
--         sources = cmp.config.sources({
--           { name = "nvim_lsp", max_item_count = 7 },
--           { name = "luasnip",  max_item_count = 7 }, -- For luasnip users.
--           { name = "buffer",   max_item_count = 7 },
--         }),
--       })
--     end,
--   },
-- }
return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp", -- optional, for advanced snippet features
        config = function()
          local luasnip = require("luasnip")
          require("luasnip.loaders.from_vscode").lazy_load() -- load friendly snippets if installed
          luasnip.config.set_config {
            history = true,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = true,
          }
          -- Keymaps for snippet navigation
          vim.keymap.set({ "i", "s" }, "<C-j>", function()
            if luasnip.jumpable(1) then luasnip.jump(1) end
          end, { silent = true })
          vim.keymap.set({ "i", "s" }, "<C-k>", function()
            if luasnip.jumpable(-1) then luasnip.jump(-1) end
          end, { silent = true })
          -- Choice selection in snippets
          vim.keymap.set("i", "<C-l>", function()
            if luasnip.choice_active() then luasnip.change_choice(1) end
          end, { silent = true })
          vim.keymap.set("i", "<C-h>", function()
            if luasnip.choice_active() then luasnip.change_choice(-1) end
          end, { silent = true })
        end,
      },
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local select_opts = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item(select_opts)
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item(select_opts)
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", keyword_length = 1 },
          { name = "luasnip", keyword_length = 2 },
          { name = "buffer", keyword_length = 3 },
          { name = "path" },
        }),
        window = {
          completion = cmp.config.window.bordered({
            winhighlight = "Normal:Normal,FloatBorder:CmpBorder,CursorLine:Visual,Search:None",
            scrollbar = true,
            col_offset = -3,
            side_padding = 1,
          }),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = { "menu", "abbr", "kind" },
          format = function(entry, item)
            local icons = {
              nvim_lsp = "λ",
              luasnip = "⋗",
              buffer = "Ω",
              path = "🖫",
            }
            item.menu = icons[entry.source.name] or entry.source.name
            return item
          end,
        },
        experimental = { ghost_text = true },
        performance = {
          max_view_entries = 8,  -- limits dropdown size
        },
      })

      vim.opt.completeopt = { "menu", "menuone", "noselect" }
    end,
  },
}

