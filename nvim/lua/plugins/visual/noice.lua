-- -- lazy.nvim
-- return {
--   {
--     "folke/noice.nvim",
--
--     enabled = true,
--
--     event = "VeryLazy",
--
--     dependencies = {
--       -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
--       "MunifTanjim/nui.nvim",
--       -- OPTIONAL:
--       --   `nvim-notify` is only needed, if you want to use the notification view.
--       --   If not available, we use `mini` as the fallback
--       -- "rcarriga/nvim-notify",
--     },
--     opts = {
--       -- add any options here
--     },
--   },
-- }
return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = {
          enabled = true,
          view = "virtualtext", -- super compact inline style ("cmdline" and "virtualtext" are other options)
          auto_open = {
            enabled = true,
            trigger = true,
            luasnip = true,
            throttle = 50,
          },
        },

      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
}
