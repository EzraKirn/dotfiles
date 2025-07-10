return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "bashls", "texlab" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    -- enabled = false,
    opts = {
      servers = {
        clangd = {
          init_options = {
            provideFormatter = false,
          },
        },
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.clangd.setup({
        cmd = {
          "clangd",
          "--log=verbose",
          "--enable-config",
          "--clang-tidy",
          "--fallback-style=none",
        },
      })
      lspconfig.cmake.setup({
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })
      lspconfig.pyright.setup({})
      lspconfig.bashls.setup {}
      lspconfig.texlab.setup {
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
              ignoredPatterns = {}, -- optional
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
            -- diagnosticsDelay = 300,
            -- latexFormatter = 'latexindent',
            -- latexindent = {
            --   ['local'] = nil, -- local is a reserved keyword
            --   modifyLineBreaks = false,
            -- },
            -- bibtexFormatter = 'texlab',
            -- formatterLineLength = 80,
          },
        },
      }
      -- lspconfig.cmake.setup {}
      -- keybinds
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>df", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>dc", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
    end,
  },
}
