local M = {}

function M.setup(lspconfig, on_attach, capabilities)
  lspconfig.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
      "clangd",
      "--background-index",          -- background indexing to improve responsiveness
      "--clang-tidy",                -- enables clang-tidy diagnostics
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
  })
end

return M
