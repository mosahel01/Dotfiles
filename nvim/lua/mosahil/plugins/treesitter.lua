return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			require("nvim-ts-autotag").setup()

			-- Map zsh to bash parser
			vim.treesitter.language.register("bash", "zsh")

			-- Native Neovim 0.12+ Highlighting & Syntax Auto-Start
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function(args)
					-- Turn on built-in vim syntax fallback
					vim.cmd("syntax on")
					-- Start native Treesitter highlighting (fails silently if parser isn't installed)
					pcall(vim.treesitter.start, args.buf)
					-- Enable indentation
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			local select = require("nvim-treesitter-textobjects.select")

			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
				},
			})

			-- Textobject keymaps (vif, vaf, vic, vac)
			local keymaps = {
				["if"] = "@function.inner",
				["af"] = "@function.outer",
				["ic"] = "@class.inner",
				["ac"] = "@class.outer",
				["ia"] = "@parameter.inner",
				["aa"] = "@parameter.outer",
			}

			for key, query in pairs(keymaps) do
				vim.keymap.set({ "x", "o" }, key, function()
					select.select_textobject(query, "textobjects")
				end, { desc = "Treesitter select " .. query })
			end
		end,
	},
}

-- return {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	branch = "master", -- Switches back to the classic framework branch
-- 	event = { "BufReadPre", "BufNewFile" },
-- 	build = ":TSUpdate",
-- 	dependencies = {
-- 		"windwp/nvim-ts-autotag",
-- 	},
-- 	config = function()
-- 		require("nvim-ts-autotag").setup()
--
-- 		require("nvim-treesitter").setup({
-- 			ensure_installed = {
-- 				"java",
-- 				"json",
-- 				"javascript",
-- 				"typescript",
-- 				"tsx",
-- 				"yaml",
-- 				"html",
-- 				"css",
-- 				"kotlin",
-- 				"c_sharp",
-- 				"prisma",
-- 				"markdown",
-- 				"ocaml",
-- 				"markdown_inline",
-- 				"swift",
-- 				"svelte",
-- 				"graphql",
-- 				"bash",
-- 				"sh",
-- 				"zsh",
-- 				"go",
-- 				"lua",
-- 				"python",
-- 				"powershell",
-- 				"vim",
-- 				"dockerfile",
-- 				"gitignore",
-- 				"query",
-- 				"vimdoc",
-- 				"c",
-- 				"rust",
-- 			},
-- 			sync_install = true,
-- 			auto_install = true,
-- 			highlight = {
-- 				enable = true,
-- 			},
-- 			indent = {
-- 				enable = true,
-- 			},
-- 		})
-- 	end,
-- }
