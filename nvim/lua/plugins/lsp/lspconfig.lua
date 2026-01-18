-- Core Neovim LSP setup (Neovim 0.11+)
return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Put per-buffer LSP keymaps here (recommended for 0.11+)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("MyLspKeymaps", { clear = true }),
      callback = function(args)
        local opts = { buffer = args.buf }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "df", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "dc", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)
      end,
    })

    -- If you previously used on_attach for common behavior, set defaults here:
    -- vim.lsp.config("*", { capabilities = ..., flags = ... })

    -- Call your server modules, but they should now use vim.lsp.config/enable internally
    require("plugins.lsp.servers.lua_ls").setup()
    require("plugins.lsp.servers.pyright").setup()
    require("plugins.lsp.servers.bashls").setup()
    require("plugins.lsp.servers.cmake").setup()
    require("plugins.lsp.servers.texlab").setup()
    require("plugins.lsp.servers.clangd").setup()
    require("plugins.lsp.servers.arduino").setup()
    require("plugins.lsp.servers.tinymist").setup()
  end,
}
