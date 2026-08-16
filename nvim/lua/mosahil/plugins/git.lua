return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local keymap = vim.keymap
		require("gitsigns").setup()
		keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
	end,
}
