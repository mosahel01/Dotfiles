return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
                kdl = { "kdlfmt" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				bash = { "shfmt" },
				python = { "isort", "black" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		-- require("conform").formatters.prettierd = {
		-- 	condition = function(self, ctx)
		-- 		-- Looks for these specific files in your current folder
		-- 		return vim.fs.find({
		-- 			".prettierrc",
		-- 			".prettierrc.json",
		-- 			".prettierrc.js",
		-- 			"prettier.config.js",
		-- 		}, { path = ctx.filename, upward = true })[1]
		-- 	end,
		-- }

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
