return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- 1. Define your languages here
		local parsers = {
			"java",
			"json",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"html",
			"css",
			"kotlin",
			"c_sharp",
			"prisma",
			"markdown",
			"ocaml",
			"markdown_inline",
			"swift",
			"svelte",
			"graphql",
			"bash",
			"go",
			"lua",
			"python",
			"powershell",
			"vim",
			"dockerfile",
			"gitignore",
			"query",
			"vimdoc",
			"c",
			"rust",
		}

		-- 2. Automatically install any parsers that are missing
		local already_installed = require("nvim-treesitter.config").get_installed()
		local parsers_to_install = vim.iter(parsers)
			:filter(function(p)
				return not vim.tbl_contains(already_installed, p)
			end)
			:totable()

		if #parsers_to_install > 0 then
			require("nvim-treesitter").install(parsers_to_install)
		end

		-- 3. Enable highlighting, indentation, and autotags natively
		require("nvim-ts-autotag").setup()

		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}

-- return {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	event = { "BufReadPre", "BufNewFile" },
-- 	build = ":TSUpdate",
-- 	dependencies = {
-- 		"windwp/nvim-ts-autotag",
-- 	},
-- 	config = function()
-- 		-- import nvim-treesitter plugin
-- 		-- local treesitter = require("nvim-treesitter")
--
-- 		-- configure treesitter
-- 		require("nvim-treesitter.configs").setup({ -- enable syntax highlighting
-- 			highlight = {
-- 				enable = true,
-- 			},
-- 			-- enable indentation
-- 			indent = { enable = true },
-- 			-- enable autotagging (w/ nvim-ts-autotag plugin)
-- 			autotag = {
-- 				enable = true,
-- 			},
-- 			-- ensure these language parsers are installed
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
-- 			incremental_selection = {
-- 				enable = true,
-- 				keymaps = {
-- 					init_selection = "<C-space>",
-- 					node_incremental = "<C-space>",
-- 					scope_incremental = false,
-- 					node_decremental = "<bs>",
-- 				},
-- 			},
-- 		})
-- 	end,
-- }
