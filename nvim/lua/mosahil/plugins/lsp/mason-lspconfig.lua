return {
	"williamboman/mason-lspconfig.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
	},
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"lua_ls",
				"graphql",
				"emmet_ls",
				"prismals",
				"pyright",
				"rust_analyzer",
				"jdtls",
				"zls",
			},
		})
	end,
}
