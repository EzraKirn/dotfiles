return {
  {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    opts = {},
    config = function()
      require("origami").setup({
        pauseFoldsOnSearch = true,
        foldKeymaps = {
          setup = true,
          hOnlyOpensOnFirstColumn = false,
        },
      })
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },
}
