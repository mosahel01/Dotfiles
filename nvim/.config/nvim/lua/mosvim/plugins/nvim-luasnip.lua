-- Minimal setup for Luasnip + Friendly snippets
-- Luasnip => snippet engine that expands shortcuts into code blocks
-- Friendly snippets => collection of pre-made snippets from various languages

-- return {
--   "L3MON4D3/LuaSnip",
--   dependencies = {
--     "rafamadriz/friendly-snippets",
--   },
--   config = function ()
--    require("luasnip.loaders.from_vscode").lazy_load()
--   end
-- }

return {
	"L3MON4D3/LuaSnip",
	version = "v2.*", -- Important for JSX support
	build = "make install_jsregexp", -- Needed for JS/TS snippet features
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load({
			paths = {
				-- Explicitly load JS/JSX snippets
				vim.fn.stdpath("data") .. "/lazy/friendly-snippets",
			},
			include = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		})
	end,
}
