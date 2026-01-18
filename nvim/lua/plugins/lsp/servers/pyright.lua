local M = {}

function M.setup()
  vim.lsp.config("pyright", {})
  vim.lsp.enable("pyright")
end

return M
