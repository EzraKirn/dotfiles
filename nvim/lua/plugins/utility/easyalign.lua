return {
  "junegunn/vim-easy-align",
  config = function()
    -- Optionally, you can customize key mappings here
    -- Default keymap is 'ga' in visual and normal mode
    vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", {})
    vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {})
  end,
}
