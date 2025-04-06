return {
  "chrisgrieser/nvim-origami",
  event = "VeryLazy",
  opts = {}, -- needed even when using default config
  config = function()
    require("origami").setup({
      -- keepFoldsAcrossSessions = true,
      pauseFoldsOnSearch = true,
      setupFoldKeymaps = true,

      -- foldKeymaps = {
      --   setup = true, -- modifies `h` and `l`
      --   hOnlyOpensOnFirstColumn = false,
      -- },
    })
  end,
}
