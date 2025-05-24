-- return {
--     -- Completion framework and snippets
--     {
--         "hrsh7th/nvim-cmp",
--         dependencies = {
--             "L3MON4D3/LuaSnip",             -- Snippet engine
--             "saadparwaiz1/cmp_luasnip",     -- LuaSnip completion source
--             "hrsh7th/cmp-nvim-lsp",         -- LSP completion source
--             "hrsh7th/cmp-buffer",           -- Buffer source
--             "hrsh7th/cmp-path",             -- Path source
--             "rafamadriz/friendly-snippets", -- VSCode-style snippets
--             "mlaursen/vim-react-snippets",
--         },
--         config = function()
--             local cmp = require("cmp")
--             local luasnip = require("luasnip")
--
--             require("luasnip.loaders.from_vscode").lazy_load()
--
--             -- {{
--             -- React Specific
--             require("vim-react-snippets").lazy_load()
--             local config = require("vim-react-snippets.config")
--             config.readonly_props = false
--             -- }}
--
--             -- Extend filetypes for snippets (JSX/TSX gets HTML snippets)
--             vim.api.nvim_create_autocmd("FileType", {
--                 pattern = { "javascriptreact", "typescriptreact" },
--                 callback = function()
--                 --     require("luasnip").filetype_extend("javascriptreact", { "html" })
--                 --     require("luasnip").filetype_extend("typescriptreact", { "html" })
--                 end,
--             })
--
--             cmp.setup({
--                 snippet = {
--                     expand = function(args)
--                         luasnip.lsp_expand(args.body)
--                     end,
--                 },
--                 mapping = cmp.mapping.preset.insert({
--                     ["<Tab>"] = cmp.mapping.select_next_item(),
--                     ["<S-Tab>"] = cmp.mapping.select_prev_item(),
--
--                     ["<C-n>"] = cmp.mapping.select_next_item(),
--                     ["<C-p>"] = cmp.mapping.select_prev_item(),
--
--                     ["<C-Space>"] = cmp.mapping.complete(),
--                     ["<C-e>"] = cmp.mapping.abort(),
--                     ["<CR>"] = cmp.mapping.confirm({ select = true }),
--                 }),
--                 sources = cmp.config.sources({
--                     { name = "nvim_lsp" },
--                     { name = "luasnip" },
--                     { name = "buffer" },
--                     { name = "path" },
--                 }),
--             })
--         end,
--     },
-- }

return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip", -- Snippet engine
			"saadparwaiz1/cmp_luasnip", -- LuaSnip completion source
			"hrsh7th/cmp-nvim-lsp", -- LSP completion source
			"hrsh7th/cmp-buffer", -- Buffer source
			"hrsh7th/cmp-path", -- Path source
			"rafamadriz/friendly-snippets", -- VSCode-style HTML & generic snippets
			"mlaursen/vim-react-snippets", -- React-specific snippets
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Load all friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Load React snippets (JSX/TSX specific)
			require("vim-react-snippets").lazy_load()
			local config = require("vim-react-snippets.config")
			config.readonly_props = false

			-- Extend HTML snippets into JSX/TSX
			luasnip.filetype_extend("javascriptreact", { "html" })
			luasnip.filetype_extend("typescriptreact", { "html" })

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "luasnip" }, -- prioritize snippets
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				sorting = {
					priority_weight = 2,
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,

						-- Prioritize snippets above keywords/variables
						function(entry1, entry2)
							local kind1 = entry1:get_kind()
							local kind2 = entry2:get_kind()
							if
								kind1 == cmp.lsp.CompletionItemKind.Snippet
								and kind2 ~= cmp.lsp.CompletionItemKind.Snippet
							then
								return true
							elseif
								kind2 == cmp.lsp.CompletionItemKind.Snippet
								and kind1 ~= cmp.lsp.CompletionItemKind.Snippet
							then
								return false
							end
						end,

						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				formatting = {
					format = function(entry, vim_item)
						-- Remove duplicated keyword/variable entries
						if entry.completion_item.dup ~= 0 then
							entry.dup = 0
						end
						return vim_item
					end,
				},
			})
		end,
	},
}
