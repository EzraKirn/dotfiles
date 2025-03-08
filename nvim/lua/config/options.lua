vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number relativenumber")
vim.cmd("set nowrap")
vim.cmd("set foldlevelstart=99")
vim.opt.foldmethod = "indent"
vim.opt.foldcolumn = "0"

-- Diagnostic settings
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
})
