local M = {}

function M.setup()
  vim.lsp.config("texlab", {
    settings = {
      texlab = {
        rootDirectory = nil,
        build = {
          executable = "latexmk",
          args = { "%f" },
          onSave = true,
          forwardSearchAfter = false,
        },
        completion = {
          includePaths = {
            "/home/grzeszko/texmf/tex/latex/mylatex/LaTexPWR",
          },
        },
        diagnostics = {
          ignoredPatterns = {},
          includePaths = {
            "/home/grzeszko/texmf/tex/latex/mylatex/LaTexPWR",
          },
          forwardSearch = {
            executable = "evince",
            args = {},
          },
          chktex = {
            onOpenAndSave = false,
            onEdit = false,
          },
        },
      },
    },
  })

  vim.lsp.enable("texlab")
end

return M
