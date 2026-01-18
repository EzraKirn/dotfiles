local M = {}

function M.setup()
  vim.lsp.config("cmake", {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  })

  vim.lsp.enable("cmake")
end

return M
