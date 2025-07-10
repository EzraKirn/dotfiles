return {
  "mfussenegger/nvim-lint",

  enabled = false,

  event = {
    "BufReadPre",
    "BufNewFile",
  },

  config = function()
    require("lint").linters_by_ft = {
      python = { "ruff" }, -- or use "flake8", "pylint", etc.
      lua = { "luacheck" },
      c = { "clangtidy" },
      cpp = { "clangtidy" },
    }

    require("lint").linters = {
      clangtidy = {
        args = { "--config-file=/home/grzeszko/dotfiles/clang_tidy/.clang-tidy" },
      },
    }
    -- Automatically lint on save
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
