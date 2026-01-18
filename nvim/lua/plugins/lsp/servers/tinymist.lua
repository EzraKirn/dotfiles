local M = {}

function M.setup()
  vim.lsp.config("tinymist", {})
  vim.lsp.enable("tinymist")
end

return M
