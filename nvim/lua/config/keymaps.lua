vim.g.mapleader = " "
-- vim.keymap.set("n", "<CR>", "m`o<Esc>``")
-- vim.keymap.set("n", "<S-CR>", "m`O<Esc>``")

vim.api.nvim_set_keymap("n", "o", "o<Esc>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "O", "O<Esc>", { noremap = true, silent = true })
