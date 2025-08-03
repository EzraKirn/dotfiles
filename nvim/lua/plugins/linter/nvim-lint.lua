-- ~/.config/nvim/lua/plugins/linter.lua

return {
  "mfussenegger/nvim-lint",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      -- cpp    = { "clangtidy" }, --just add .clangtidy and shit will happend automagicly
      -- c      = { "clangtidy" },
      python = { "flake8" },   -- requires pip install flake8
      lua    = { "luacheck" }, -- requires pacman -S luacheck
    }

    -- Lint on save and buffer enter
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
      callback = function()
        lint.try_lint()
      end,
    })

    -- Optional: keymap for manual lint trigger
    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Lint current file" })

    vim.api.nvim_create_user_command("LintInfo", function()
      print("Active linters: " .. table.concat(require("lint").get_running(), ", "))
    end, {})
  end,
}
