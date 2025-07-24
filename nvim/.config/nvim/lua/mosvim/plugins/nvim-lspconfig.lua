-- nvim-mason -> installs LSP servers --> Provides Language Intellisense -> Feeds into --> Nvim-lspconfig --> sends data to --> nvim-cmp --> Displays --> Auto-completions

-- You open a .TS file
-- Mason installs typescript-language-server (if missing)
-- Lspconfig starts the server and attaches to buffer
-- as you type, Nvim-cmp shows completions from TS server
-- you use lspconfig keybinds to navigate definitions

local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- -- Debugging
-- vim.lsp.set_log_level("Debugging") -- Temporary for Troubleshooting

-- -- In tsserver/ts_ls setup
-- lspconfig.tsserver.setup({
-- 	capabilities = require("cmp_nvim_lsp").default_capabilities(),
-- })






return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		-- local utils = require("lspconfig.util")
		local telescope = require("telescope.builtin")
		local util = require("lspconfig.util") -- Required for tailwindcss root_dir

		-- Basic capabilities
		local capabilities = cmp_nvim_lsp.default_capabilities()
		-- local capabilities = vim.lsp.protocol.make_client_capabilities()

		-- Common on_attach function
		local on_attach = function(client, bufnr)
			local bufopts = { noremap = true, silent = true, buffer = bufnr }

			vim.keymap.set("n", "gd", telescope.lsp_definitions, bufopts)
			-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)  -- textDocument/declaration not supported
			vim.keymap.set("n", "gr", telescope.lsp_references, bufopts)
			vim.keymap.set("n", "gi", telescope.lsp_implementations, bufopts)
			vim.keymap.set("n", "gt", telescope.lsp_type_definitions, bufopts)
			vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
			vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
			-- vim.keymap.set("n", "gD", telescope.vim.diagnostics.open_floa, bufopts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
			-- deez nuts don't work, im lazy to get them working
			-- EDIT: got em working yay! (no paru!!)
			vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
			vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
			-- vim.keymap.set("n", "[d", '<cmd>lua vim.lsp.diagnostics.goto_next()<cr>')
			-- vim.keymap.set("n", "[d", '<cmd>lua vim.lsp.diagnostics.goto_next()<cr>')
			vim.keymap.set("n", "<leader>ws", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>")
		end

		-- Configure language servers




    -- Java
    -- i miss neovim for java but lets get going with intellij













		-- TypeScript/JavaScript
		lspconfig.ts_ls.setup({ -- Changed from tsserver to ts_ls
			capabilities = capabilities,
			on_attach = on_attach,
			init_options = { hostInfo = "neovim" },
			cmd = { "typescript-language-server", "--stdio" },
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
				"tsx",
			},
			root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
			handlers = {
				-- handle rename request for certain code actions like extracting functions / types
				["_typescript.rename"] = function(_, result, ctx)
					local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
					vim.lsp.util.show_document({
						uri = result.textDocument.uri,
						range = {
							start = result.position,
							["end"] = result.position,
						},
					}, client.offset_encoding)
					vim.lsp.buf.rename()
					return vim.NIL
				end,
			},
			commands = {
				["editor.action.showReferences"] = function(command, ctx)
					local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
					local file_uri, position, references = unpack(command.arguments)

					local quickfix_items = vim.lsp.util.locations_to_items(references, client.offset_encoding)
					vim.fn.setqflist({}, " ", {
						title = command.title,
						items = quickfix_items,
						context = {
							command = command,
							bufnr = ctx.bufnr,
						},
					})

					vim.lsp.util.show_document({
						uri = file_uri,
						range = {
							start = position,
							["end"] = position,
						},
					}, client.offset_encoding)

					vim.cmd("botright copen")
				end,
			},
			on_attach = function(client, bufnr)
				-- ts_ls provides `source.*` code actions that apply to the whole file. These only appear in
				-- `vim.lsp.buf.code_action()` if specified in `context.only`.
				vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptSourceAction", function()
					local source_actions = vim.tbl_filter(function(action)
						return vim.startswith(action, "source.")
					end, client.server_capabilities.codeActionProvider.codeActionKinds)

					vim.lsp.buf.code_action({
						context = {
							only = source_actions,
						},
					})
				end, {})
			end,
		})

		-- 	-- IF THE ABOVE TS_LS DOESN'T WORK, USE THIS ONE
		-- 	init_options = { hostInfo = "neovim" },
		-- 	cmd = { "typescript-language-server", "--stdio" },
		-- 	filetypes = {
		-- 		"javascript",
		-- 		"javascriptreact",
		-- 		"javascript.jsx",
		-- 		"typescript",
		-- 		"typescriptreact",
		-- 		"typescript.tsx", -- Fixed extension
		-- 	},
		-- 	root_dir = util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
		-- 	single_file_support = true,
		-- })

		-- 	-- THIRD OPTION
		-- 	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		-- 	cmd = { "typescript-language-server", "--stdio" },
		-- 	root_dir = function(...)
		-- 		return require("lspconfig.util").root_pattern(".git")(...)
		-- 	end,
		-- 	single_file_support = false,
		-- 	settings = {
		-- 		typescript = {
		-- 			inlayHints = {
		-- 				includeInlayParameterNameHints = "literal",
		-- 				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
		-- 				includeInlayFunctionParameterTypeHints = true,
		-- 				includeInlayVariableTypeHints = false,
		-- 				includeInlayPropertyDeclarationTypeHints = true,
		-- 				includeInlayFunctionLikeReturnTypeHints = true,
		-- 				includeInlayEnumMemberValueHints = true,
		-- 			},
		-- 		},
		-- 		javascript = {
		-- 			inlayHints = {
		-- 				includeInlayParameterNameHints = "all",
		-- 				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
		-- 				includeInlayFunctionParameterTypeHints = true,
		-- 				includeInlayVariableTypeHints = true,
		-- 				includeInlayPropertyDeclarationTypeHints = true,
		-- 				includeInlayFunctionLikeReturnTypeHints = true,
		-- 				includeInlayEnumMemberValueHints = true,
		-- 			},
		-- 		},
		-- 	},
		-- })

		-- Svelte
		lspconfig.svelte.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "svelte" },
		})

		-- CSS
		lspconfig.cssls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- Tailwind CSS
		lspconfig.tailwindcss.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = {
				"aspnetcorerazor",
				"astro",
				"astro-markdown",
				"blade",
				"clojure",
				"django-html",
				"htmldjango",
				"edge",
				"eelixir",
				"elixir",
				"ejs",
				"erb",
				"eruby",
				"gohtml",
				"gohtmltmpl",
				"haml",
				"handlebars",
				"hbs",
				"html",
				"htmlangular",
				"html-eex",
				"heex",
				"jade",
				"leaf",
				"liquid",
				"markdown",
				"mdx",
				"mustache",
				"njk",
				"nunjucks",
				"php",
				"razor",
				"slim",
				"twig",
				"css",
				"less",
				"postcss",
				"sass",
				"scss",
				"stylus",
				"sugarss",
				"javascript",
				"javascriptreact",
				"reason",
				"rescript",
				"typescript",
				"typescriptreact",
				"vue",
				"svelte",
			},
			root_dir = function(fname)
				return util.root_pattern(
					"tailwind.config.js",
					"tailwind.config.cjs",
					"tailwind.config.mjs",
					"tailwind.config.ts",
					"postcss.config.js",
					"postcss.config.cjs",
					"postcss.config.mjs",
					"postcss.config.ts",
					"package.json"
				)(fname) or util.find_git_ancestor(fname)
			end,
		})

		-- Lua
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			root_markers = {
				".luarc.json",
				".luarc.jsonc",
				".luacheckrc",
				"stylua.toml",
				"selene.toml",
				".selene.yml",
				".git",
			},
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = {
						globals = { "vim" },
						disable = { "missing-fields" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = { enable = false },
				},
			},
		})

		-- Hypr
		lspconfig.hyprls.setup({
			cmd = { "hyprls", "--stdio" },
      filetypes = { "hypr" },
			root_markers = { ".git" },
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- -- PostgreSQL || Postgreql specific
		-- lspconfig.postgres_lsp.setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- 	init_options = { hostInfo = "neovim" },
		-- 	cmd = { "postgrestools", "lsp-proxy" },
		-- 	filetypes = {
		-- 		"sql",
		-- 	},
		-- 	root_markers = { "postgrestools.jsonc" },
		-- 	-- root_dir = utils.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
		-- 	-- single_file_support = true,
		-- })

		-- -- Sql
		-- lspconfig.sqls.setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- 	cmd = { "sqls" },
		-- 	root_markers = { "config.yml" },
		-- 	filetypes = {
		-- 		"sql",
		-- 		"mysql",
		-- 	},
		-- 	settings = {},
		-- })

		-- PostgreSQL/Sqlls  | not sure which one is right SQL LSP
		-- Googled | its better and works for all SQL dialects
		-- Update your sqlls setup to include completion capabilities
		lspconfig.sqlls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { "sql-language-server", "up", "--method", "stdio" },
			filetypes = { "sql", "mysql", "postgres" },
			root_markers = { ".sqllsrc.json" },
			settings = {
				sql = {
					format = {
						uppercase = true,
					},
					completion = {
						enable = true, -- Ensure completions are enabled
					},
				},
			},
		})
	end,
}
