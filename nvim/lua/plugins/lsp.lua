return {
  -- Mason: LSP/DAP/Linter installer
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason LSPConfig: Bridges mason + lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "bashls",
          "texlab",
          "clangd",
          "cmake",
        },
      })
    end,
  },

  -- Clangd Extensions: Adds extra features for C++ (AST, inlay hints, easy switch header/source)
  {
    "p00f/clangd_extensions.nvim",
    lazy = false,
    config = function()
      require("clangd_extensions").setup({
        server = {
          cmd = {
            "clangd",
            "--log=verbose",
            "--enable-config",
            "--clang-tidy",
            "--fallback-style=none",
          },
          init_options = {
            provideFormatter = false,
          },
        },
      })
      vim.keymap.set("n", "<leader>sh", "<cmd>ClangdSwitchSourceHeader<CR>")
      vim.keymap.set("n", "<leader>ast", "<cmd>ClangdAST<CR>")
      vim.keymap.set("n", "<leader>th", "<cmd>ClangdTypeHierarchy<CR>")
      vim.keymap.set("n", "<leader>si", "<cmd>ClangdSymbolInfo<CR>")
      vim.keymap.set("n", "<leader>mu", "<cmd>ClangdMemoryUsage<CR>")
      vim.keymap.set("n", "<leader>ih", "<cmd>ClangdInlayHintsToggle<CR>")
    end,
  },

  -- generate.nvim: C++ declaration/definition generator
  {
    "eriks47/generate.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    config = function()
      require("generate").setup()
      vim.keymap.set("n", "<leader>gdf", ":Generate implementations<CR>", { desc = "Generate C++ implementations" })
      vim.keymap.set("n", "<leader>gdc", ":Generate declarations<CR>", { desc = "Generate C++ declarations" })
    end,
  },

  -- Core Neovim LSPConfig setup
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {},
        pyright = {},
        bashls = {},
        texlab = {},
        cmake = {},
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>df", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>dc", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})

      -- Language servers
      lspconfig.lua_ls.setup({ on_attach = on_attach })
      lspconfig.pyright.setup({ on_attach = on_attach })
      lspconfig.bashls.setup({ on_attach = on_attach })
      lspconfig.cmake.setup({
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          on_attach(client, bufnr)
        end,
      })

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
    end,
  },
}
