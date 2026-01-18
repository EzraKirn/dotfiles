local M = {}

function M.setup()
  vim.lsp.config("arduino_language_server", {
    cmd = { "arduino-language-server", "-fqbn", "arduino:avr:uno" },
    filetypes = { "arduino", "ino" },
    root_dir = function(bufnr, _)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      return vim.fs.root(fname, { ".git", "*.ino" })
    end,
  })

  vim.lsp.enable("arduino_language_server")
end

return M
