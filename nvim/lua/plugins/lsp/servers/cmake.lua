local M = {}

function M.setup(lspconfig, on_attach)
  lspconfig.cmake.setup({
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      on_attach(client, bufnr)
    end,
  })
end

return M
