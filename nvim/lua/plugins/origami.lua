return {
	"chrisgrieser/nvim-origami",
	event = "VeryLazy",
	opts = {}, -- needed even when using default config
	config = function()
		require("origami").setup({
			keepFoldsAcrossSessions = true,
			pauseFoldsOnSearch = true,
			setupFoldKeymaps = true,

			-- `h` key opens on first column, not at first non-blank character or before
			hOnlyOpensOnFirstColumn = false,
		})
	end,
}
