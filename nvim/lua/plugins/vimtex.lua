return {
  "lervag/vimtex",
  enabled = false,
  ft = "tex",
  init = function()
    -- Set compiler to lualatex
    vim.g.vimtex_compiler_latexmk_engines = { _ = '-lualatex' }
    vim.g.vimtex_compiler_latexmk = {
      backend = 'nvim',
      build_dir = '',
      callback = 1,
      continuous = 1,
      executable = 'latexmk',
      options = {
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      }
    }

    vim.g.vimtex_view_general_viewer = 'evince'
    vim.g.vimtex_view_forward_search_on_start = 1
    vim.g.vimtex_compiler_start_on_save = 1
    vim.g.vimtex_compiler_latexmk_use_miktex = 0
  end,
}
