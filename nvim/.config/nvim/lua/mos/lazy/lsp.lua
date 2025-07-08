-- plugins/lsp.lua
return {
    -- {
    --     "williamboman/mason.nvim",
    --     dependancies = {
    --         "mason-org/mason-lspconfig.nvim",
    --         "neovim/nvim-lspconfig"
    --     },
    --     opts = function(_, opts)
    --         opts.ensure_installed = opts.ensure_installed or {}
    --         vim.list_extend(opts.ensure_installed, {
    --             "emmet-ls"  ,
    --             "html",
    --             "css",
    --             "scss",
    --             "javascript",
    --             "javascriptreact",
    --             "typescriptreact",
    --             "vue",
    --             "svelte",
    --         })
    --     end,
    -- },

    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall" },
        opts = {
            ensure_installed = {
                "ts_ls", -- TypeScript/JavaScript
                "prettier",
                "eslint_d",
                "cssls",       -- CSS
                "tailwindcss", -- Tailwind CSS
                "html",        -- HTML
                "yamlls",      -- YAML
                "lua_ls",      -- Lua
                "emmet-ls",    -- Emmet for HTML/JSX/TSX
                "stylua",      -- Lua formatter
                "selene",      -- Lua linter
                "luacheck",    -- Lua linter
                "shellcheck",  -- Shell script linter
                "shfmt",       -- Shell script formatter
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
        end,
    },
    -- Mason-LSPConfig: Automatically install LSP servers
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = {
                "ts_ls",
                "cssls",
                "tailwindcss",
                "html",
                "yamlls",
                "lua_ls",
                "emmet_ls",
            },
            automatic_installation = true,
        },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)
        end,
    },
    -- LSP: nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "nvim-telescope/telescope.nvim", -- For Telescope LSP keybindings
        },
        opts = {
            servers = {
                ts_ls = {
                    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
                    root_dir = function(...)
                        return require("lspconfig.util").root_pattern(".git")(...)
                    end,
                    single_file_support = false,
                    settings = {
                        typescript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "literal",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = false,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                        },
                        javascript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "all",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                        },
                    },
                },
                html = {
                    filetypes = { "html", "javascriptreact", "typescriptreact" },
                },
                cssls = {
                    filetypes = { "css", "scss", "less" },
                },
                tailwindcss = {
                    filetypes = { "html", "javascriptreact", "typescriptreact" },
                    root_dir = function(...)
                        return require("lspconfig.util").root_pattern("tailwind.config.js", "tailwind.config.ts", ".git")(...)
                    end,
                },
                yamlls = {
                    settings = {
                        yaml = {
                            keyOrdering = false,
                        },
                    },
                },
                lua_ls = {
                    single_file_support = true,
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                            completion = {
                                workspaceWord = true,
                                callSnippet = "Both",
                            },
                            hint = {
                                enable = true,
                                setType = false,
                                paramType = true,
                                paramName = "Disable",
                                semicolon = "Disable",
                                arrayIndex = "Disable",
                            },
                            doc = {
                                privateName = { "^_" },
                            },
                            type = {
                                castNumberToInteger = true,
                            },
                            diagnostics = {
                                disable = { "incomplete-signature-doc", "trailing-space" },
                                groupSeverity = {
                                    strong = "Warning",
                                    strict = "Warning",
                                },
                                groupFileStatus = {
                                    ["ambiguity"] = "Opened",
                                    ["await"] = "Opened",
                                    ["codestyle"] = "None",
                                    ["duplicate"] = "Opened",
                                    ["global"] = "Opened",
                                    ["luadoc"] = "Opened",
                                    ["redefined"] = "Opened",
                                    ["strict"] = "Opened",
                                    ["strong"] = "Opened",
                                    ["type-check"] = "Opened",
                                    ["unbalanced"] = "Opened",
                                    ["unused"] = "Opened",
                                },
                                unusedLocalExclude = { "_*" },
                            },
                            format = {
                                enable = false,
                                defaultConfig = {
                                    indent_style = "space",
                                    indent_size = "2",
                                    continuation_indent_size = "2",
                                },
                            },
                        },
                    },
                },
                emmet_ls = {
                    filetypes = {
                        "html",
                        "css",
                        "scss",
                        "javascript",
                        "javascriptreact",
                        "typescriptreact",
                        "vue",
                        "svelte",
                    },
                },
            },
            setup = {},
        },
        config = function(_, opts)
            local lspconfig = require("lspconfig")
            local telescope = require("telescope.builtin")
            local on_attach = function(client, bufnr)
                local bufmap = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
                end
                -- bufmap("gd", function() telescope.lsp_definitions({ reuse_win = false }) end, "Goto Definition")
                bufmap("gd", telescope.lsp_definitions, "Goto Definition")
                bufmap("gr", telescope.lsp_references, "Goto References")
                bufmap("K", vim.lsp.buf.hover, "Hover Documentation")
                bufmap("<leader>rn", vim.lsp.buf.rename, "Rename")
                bufmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")

                -- New keybindings
                -- Diagnostics navigation
                bufmap("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
                bufmap("]d", vim.diagnostic.goto_next, "Next Diagnostic")
                bufmap("<leader>dl", telescope.diagnostics, "Show All Diagnostics")

                -- Go to implementation
                bufmap("gi", telescope.lsp_implementations, "Goto Implementation")

                -- Go to type definition
                bufmap("gt", telescope.lsp_type_definitions, "Goto Type Definition")

                -- Format document
                bufmap("<leader>fmt", vim.lsp.buf.format, "Format Document")

                -- Signature help
                bufmap("<C-k>", vim.lsp.buf.signature_help, "Signature Help", "i")
                bufmap("<leader>ws", telescope.lsp_workspace_symbols, "Workspace Symbols")
                bufmap("<leader>ds", telescope.lsp_document_symbols, "Document Symbols")
                bufmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
                bufmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
                bufmap("<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, "List Workspace Folders")

                -- Notify if LSP client supports code actions
                if client.server_capabilities.codeActionProvider then
                    vim.notify("Code actions supported for " .. client.name, vim.log.levels.INFO)
                end
            end

            -- Setup each server with the provided options
            for server, server_opts in pairs(opts.servers) do
                local final_opts = vim.tbl_deep_extend("force", server_opts, { on_attach = on_attach })
                lspconfig[server].setup(final_opts)
            end
        end,
    },
}
