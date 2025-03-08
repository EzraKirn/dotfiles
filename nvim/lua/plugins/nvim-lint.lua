-- return {
-- 	"mfussenegger/nvim-lint",
--
-- 	enabled = true,
--
-- 	event = {
-- 		"BufReadPre",
-- 		"BufNewFile",
-- 	},
-- 	opts = {
-- 		linters_by_ft = {
-- 			c = { "clangtidy" },
-- 			cpp = { "clangtidy" },
-- 			lua = { "luacheck" },
-- 		},
-- 		linters = {
-- 			clangtidy = {
-- 				args = { "--config-file=/home/grzeszko/dotfiles/clang_tidy/.clang-tidy" },
-- 			},
-- 		},
-- 	},
-- 	config = function(_, opts)
-- 		local lint = require("lint")
--
-- 		lint.linters_by_ft = opts.linters_by_ft
--
-- 		-- Apply custom linter options
-- 		for linter, config in pairs(opts.linters or {}) do
-- 			if lint.linters[linter] then
-- 				for key, value in pairs(config) do
-- 					lint.linters[linter][key] = value
-- 				end
-- 			end
-- 		end
--
-- 		-- Automatically lint on save, buffer read, or exiting insert mode
-- 		vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost", "BufReadPost" }, {
-- 			callback = function()
-- 				require("lint").try_lint()
-- 			end,
-- 		})
-- 	end,
-- }

return {
	"mfussenegger/nvim-lint",

	enabled = false,

	event = {
		"BufReadPre",
		"BufNewFile",
	},

	config = function()
		require("lint").linters_by_ft = {
			python = { "ruff" }, -- or use "flake8", "pylint", etc.
			lua = { "luacheck" },
			c = { "clangtidy" },
			cpp = { "clangtidy" },
		}

		require("lint").linters = {
			clangtidy = {
				args = { "--config-file=/home/grzeszko/dotfiles/clang_tidy/.clang-tidy" },
			},
		}
		-- Automatically lint on save
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
