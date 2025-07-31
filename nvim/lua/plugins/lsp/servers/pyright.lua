local M = {}

function M.setup(lspconfig, on_attach)
  lspconfig.pyright.setup({
    on_attach = on_attach,
  })
end

return M
