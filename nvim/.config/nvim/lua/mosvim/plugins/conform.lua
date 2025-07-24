return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				css = { "prettier" },
				html = { "prettier" },
				svelte = { "prettier" },
				java = { "google-java-format" },
				-- java = { "jdtls" },
			},
			formatters = {
				["google-java-format"] = {
					prepend_args = { "--aosp" }, -- Ensures 4-space indentation
				},
			},
			-- format_on_save = {
			-- 	timeout_ms = 500,
			-- 	lsp_fallback = true,
			-- },
		})

		-- Keymap to format current buffer
		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ bufnr = 0, async = true })
		end, { desc = "Format Buffer" })
	end,
}
