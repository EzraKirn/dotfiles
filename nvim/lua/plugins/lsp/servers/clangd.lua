local M = {}

function M.setup(lspconfig, on_attach, capabilities)
  lspconfig.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
      "clangd",
      "--clang-tidy",                -- background indexing to improve responsiveness
      "--background-index",          -- background indexing to improve responsiveness
      "--header-insertion=iwyu",     -- include-what-you-use style header insertion
      "--completion-style=detailed", -- detailed completion items
      "--function-arg-placeholders",
      "--fallback-style=llvm",       -- fallback style for formatting
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
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
    vim.keymap.set("n", "<leader>h", "<cmd>ClangdSwitchSourceHeader<CR>")
  })
end

return M
