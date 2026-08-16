return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	config = function()
		require("dressing").setup({
			select = {
				enabled = true,
				backend = {
					"telescope",
					"fzf_lua",
					"fzf",
				},
				-- telescope = require("telescoope.themes").get_dropdown({
				-- 	-- telescope theme here
				-- }),
			},
		})
	end,
}
