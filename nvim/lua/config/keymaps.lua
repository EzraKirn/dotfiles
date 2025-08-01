vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- vim.api.nvim_set_keymap("n", "o", "o<Esc>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "O", "O<Esc>", { noremap = true, silent = true })

-- lsp commands
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>df", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>dc", vim.lsp.buf.declaration)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

-- clangd commands
vim.keymap.set("n", "<leader>sh", "<cmd>ClangdSwitchSourceHeader<CR>")
