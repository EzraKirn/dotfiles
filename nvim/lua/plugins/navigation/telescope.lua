return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = {
            "vendor/",
            "node_modules/",
            "build/",
            "bin/",
            "submodules/",
            "%.lock",          -- lock files
            "%.min%.js",       -- minified JS
            "%.pdf",           -- PDF files
            "%.png",           -- PNG images
            "%.jpg", "%.jpeg", -- JPEG images
            "%.gif",           -- GIFs
            "%.svg",           -- SVGs
            "%.webp",          -- WebP images
          },
        },
        extensions = { ["ui-select"] = { require("telescope.themes").get_dropdown({}), }, },
      })

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader><leader>", builtin.find_files, {})
      vim.keymap.set("n", "<leader>b", builtin.buffers, {})
      vim.keymap.set("n", "<leader>s", builtin.lsp_document_symbols, {})
      vim.keymap.set("n", "<leader>git", builtin.git_files, {})
      vim.keymap.set("n", "<leader>ref", builtin.lsp_references, {})
      vim.keymap.set("n", "<leader>of", builtin.oldfiles, {})

      require("telescope").load_extension("ui-select")
    end,
  },
}
