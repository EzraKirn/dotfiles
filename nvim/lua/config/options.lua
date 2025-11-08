vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number relativenumber")
vim.cmd("set nowrap")
vim.cmd("set foldlevelstart=99")
vim.cmd("set clipboard=unnamedplus")
vim.opt.foldmethod = "indent"
vim.opt.foldcolumn = "0"
vim.o.swapfile = false
vim.cmd([[set spell]])
vim.cmd([[set spelllang=pl,en]])

-- Diagnostic settings
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = true,
  signs = true,
  underline = true,
})
