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
      require("plugins.lsp.servers.arduino").setup(lspconfig, on_attach)
      require("plugins.lsp.servers.tinymist").setup(lspconfig, on_attach)

      -- keymapings
      vim.keymap.set("n", "K", vim.lsp.buf.hover)
      vim.keymap.set("n", "<leader>df", vim.lsp.buf.definition)
      vim.keymap.set("n", "<leader>dc", vim.lsp.buf.declaration)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
    end,
  },
}
