return {
  "danymat/neogen",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require('neogen').setup({})
  end,
  -- Optionally load for specific filetypes:
  ft = { "c", "cpp", "python", "java", "lua" }
}
