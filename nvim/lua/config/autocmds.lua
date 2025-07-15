-- Define the augroup and save its handle
local group = vim.api.nvim_create_augroup("AutoSaveFolds", { clear = true })


vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    -- Check if the current line is inside a fold
    if vim.fn.foldclosed('.') ~= -1 then
      vim.cmd('foldclose')
    end
  end
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorMoved' }, {
  pattern = '*',
  callback = function()
    if vim.fn.foldclosed('.') ~= -1 then
      vim.cmd('foldclose')
    end
  end
})
