local M = {}

function M.setup()
  vim.lsp.config("bashls", {})
  vim.lsp.enable("bashls")
end

return M
