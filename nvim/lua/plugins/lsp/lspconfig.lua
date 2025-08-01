-- Core Neovim LSPConfig setup
return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Define your on_attach function (or require it from elsewhere)
      local function on_attach(client, bufnr)

      end

      require("plugins.lsp.servers.lua_ls").setup(lspconfig, on_attach)
      require("plugins.lsp.servers.pyright").setup(lspconfig, on_attach)
      require("plugins.lsp.servers.bashls").setup(lspconfig, on_attach)
      require("plugins.lsp.servers.cmake").setup(lspconfig, on_attach)
      require("plugins.lsp.servers.texlab").setup(lspconfig, on_attach)
      require("plugins.lsp.servers.clangd").setup(lspconfig, on_attach)
    end,
  },
}
