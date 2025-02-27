return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },

	keys = {
		{
			"<leader>ff",
			function()
				require("conform").format({ lsp_fallback = true, async = false, quiet = false, timeout_ms = 3000 })
			end,
			mode = { "n", "v" },
			desc = "Format Injected Langs",
		},
	},

	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			cpp = { "clang-format" },
		},

		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 500,
		},

		formatters = {
			clang_format = {
				-- Change where to find the command
				command = "/usr/bin/clang-format",
				prepend_args = { "--style=file:~/dotfiles/clang_format" },
			},
		},
	},

	-- config = function(_, opts)
	-- 	local conform = require("conform")
	--
	-- 	conform.setup({
	-- 		formatters_by_ft = {
	-- 			lua = { "stylua" },
	-- 			cpp = { "clang-format" },
	-- 		},
	--
	-- 		format_on_save = {
	-- 			lsp_format = "fallback",
	-- 			timeout_ms = 500,
	-- 		},
	-- 	})
	-- end,
}
