return {
	"TuringProblem/shifty-vim",
	config = function()
		require("shifty").setup({
			keymaps = {
				toggle = "<leader>st",
				run = "<leader>sr",
				clear = "<leader>sc",
			},
		})
	end,
}
