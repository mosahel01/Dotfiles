
return {
    -- Completion framework and snippets
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",             -- Snippet engine
            "saadparwaiz1/cmp_luasnip",     -- LuaSnip completion source
            "hrsh7th/cmp-nvim-lsp",         -- LSP completion source
            "hrsh7th/cmp-buffer",           -- Buffer source
            "hrsh7th/cmp-path",             -- Path source
            "rafamadriz/friendly-snippets", -- VSCode-style snippets
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            require("luasnip.loaders.from_vscode").lazy_load()

            -- Extend filetypes for snippets (JSX/TSX gets HTML snippets)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "javascriptreact", "typescriptreact" },
                callback = function()
                    require("luasnip").filetype_extend("javascriptreact", { "html" })
                    require("luasnip").filetype_extend("typescriptreact", { "html" })
                end,
            })

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
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },

}
