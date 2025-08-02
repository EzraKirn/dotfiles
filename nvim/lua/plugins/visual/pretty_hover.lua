return {
  -- Pretty Hover for enhanced LSP hovers
  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    config = function()
      require("pretty_hover").setup({})
      -- Optional: remap 'K' to use pretty hover instead of default
      vim.keymap.set("n", "K", require("pretty_hover").hover, { desc = "LSP Hover (Pretty)" })
    end,
  },
}


