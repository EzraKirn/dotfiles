return {
  -- Catppuccin color scheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        integrations = {
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
            inlay_hints = { background = true },
          },
          treesitter = true,
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")

      -- Optionally reinforce float styling for consistency
      local colors = require("catppuccin.palettes").get_palette "mocha"
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.base })
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.blue, bg = colors.base })
    end,
  },
}

