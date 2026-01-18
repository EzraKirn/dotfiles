local M = {}

function M.setup()
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        telemetry = { enable = false },
        diagnostics = { globals = { "vim" } },
      },
    },
  })

  vim.lsp.enable("lua_ls")
end

return M
