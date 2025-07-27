local group = vim.api.nvim_create_augroup("PersistentFolds", { clear = true })

vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "*.*",
  callback = function()
    vim.cmd.mkview()
  end,
  group = group,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*.*",
  callback = function()
    vim.cmd.loadview({ mods = { emsg_silent = true } })
  end,
  group = group,
})
