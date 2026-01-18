-- lua/plugins/compleation/nvim-cmp.lua

-- Fixed: proper LuaSnip config location + real keymaps + visible borders [file:5]

return {
  "hrsh7th/nvim-cmp",

  event = "InsertEnter",

  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",

    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp", -- optional
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })

      -- Snippet jump keymaps
      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        end
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { silent = true })
      vim.keymap.set("i", "<C-l>", function()
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        end
      end, { silent = true })
      vim.keymap.set("i", "<C-h>", function()
        if luasnip.choice_active() then
          luasnip.change_choice(-1)
        end
      end, { silent = true })
    end,
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Define highlights for visible borders (consistent with Noice/Pretty hover)
    vim.api.nvim_set_hl(0, "NoicePopupmenu", { link = "Pmenu" })
    vim.api.nvim_set_hl(0, "NoicePopupmenuBorder", { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "NoicePopupmenuSelected", { link = "PmenuSel" })
    vim.api.nvim_set_hl(0, "CmpBorder", { link = "FloatBorder" })

    local select_opts = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
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
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp", keyword_length = 1 },
        { name = "luasnip",  keyword_length = 2 },
        { name = "buffer",   keyword_length = 3 },
        { name = "path" },
      }),

      window = {
        completion = cmp.config.window.bordered({
          border = "rounded",
          winhighlight =
          "Normal:NoicePopupmenu,FloatBorder:NoicePopupmenuBorder,CursorLine:NoicePopupmenuSelected,Search:None",
          scrollbar = false,
          col_offset = -3,
          side_padding = 1,
        }),
        documentation = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "Normal:NoicePopupmenu,FloatBorder:NoicePopupmenuBorder,Search:None",
        }),
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

      experimental = { ghost_text = false },

      performance = {
        max_view_entries = 8,
      },
    })

    vim.opt.completeopt = { "menu", "menuone", "noselect" }
  end,
}
