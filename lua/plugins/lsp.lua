return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
      ensure_installed = {"lua_ls","clangd","pyright"}
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.clangd.setup({})
      lspconfig.pyright.setup({})
      

      -- keybinds
      vim.keymap.set('n', 'K',vim.lsp.buf.hover,{})
      vim.keymap.set('n', '<leader>df',vim.lsp.buf.definition,{})
      vim.keymap.set('n', '<leader>dc',vim.lsp.buf.declaration,{})
      vim.keymap.set('n', '<leader>ca',vim.lsp.buf.code_action,{})
      vim.keymap.set('n', '<leader>rn',vim.lsp.buf.rename,{})
    end
  }
}
