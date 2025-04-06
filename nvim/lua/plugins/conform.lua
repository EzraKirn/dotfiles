return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },

  keys = {
    {
      "<leader>ff",
      function()
        require("conform").format({ lsp_fallback = true, async = false, quiet = false, timeout_ms = 3000 })
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },

  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      cpp = { "clang-format" },
    },

    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 500,
    },

    formatters = {
      clang_format = {
        -- Change where to find the command
        inherit = false,
        command = "/usr/bin/clang-format",
        args = { "--style=file" },
        -- args = { "--style=GNU" },
        -- args = { "--style=file:/home/grzeszko/dotfiles/.clang_format" },
        -- prepend_args = { "--style=file:/home/grzeszko/dotfiles/.clang_format" },
      },
    },
  },

}
