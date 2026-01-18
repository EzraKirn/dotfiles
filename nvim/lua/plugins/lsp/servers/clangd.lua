local M = {}

function M.setup()
  vim.lsp.config("clangd", {
    cmd = {
      "clangd",
      "--clang-tidy",
      "--background-index",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = function(bufnr, _)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      return vim.fs.root(fname, { "compile_commands.json", "compile_flags.txt", ".git" })
    end,
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
    settings = {
      clangd = {
        fallbackFlags = { "-std=c++17" },
      },
    },
    on_attach = function(client, bufnr)
      vim.keymap.set("n", "h", "<cmd>ClangdSwitchSourceHeader<CR>", { buffer = bufnr })
    end,
  })

  vim.lsp.enable("clangd")
end

return M
