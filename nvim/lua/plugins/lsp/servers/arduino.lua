local M = {}

function M.setup(lspconfig, on_attach)
  lspconfig.arduino_language_server.setup({
    cmd = { "arduino-language-server", "-fqbn", "arduino:avr:uno" },
    filetypes = { "arduino", "ino" },
    root_dir = lspconfig.util.root_pattern("*.ino", ".git"),
    on_attach = on_attach,
  })
end

return M
