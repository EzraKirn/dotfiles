-- lua/plugins/lsp/servers/lua_ls.lua
local M = {}

function M.setup(lspconfig, on_attach)
  lspconfig.lua_ls.setup({
    on_attach = on_attach,
    -- Add any lua_ls-specific settings here
  })
end

return M
