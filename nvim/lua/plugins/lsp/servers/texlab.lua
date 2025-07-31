local M = {}

function M.setup(lspconfig, on_attach)
  lspconfig.texlab.setup({
    on_attach = on_attach,
    settings = {
      texlab = {
        rootDirectory = nil,
        build = {
          executable = 'latexmk',
          args = { '%f' },
          onSave = true,
          forwardSearchAfter = false,
        },
        completion = {
          includePaths = {
            "/home/grzeszko/texmf/tex/latex/mylatex/LaTexPWR"
          }
        },
        diagnostics = {
          ignoredPatterns = {},
          includePaths = {
            "/home/grzeszko/texmf/tex/latex/mylatex/LaTexPWR"
          }
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
  })
end

return M
