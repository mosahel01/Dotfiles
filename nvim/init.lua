vim.g.mapleader = " "

vim.o.nu = true
vim.o.rnu = true
vim.o.wrap = false
vim.o.signcolumn = "yes:1"

vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.breakindent = true

vim.o.hlsearch = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.ignorecase = true

vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"

-- autocmds
vim.api.nvim_create_autocmd("Filetype", {
    pattern = {
        "python",
        "sql",
        "postgres",
        "yaml",
        "json",
        "toml",
    },
    callback = function()
        vim.bo.expandtab = true
    end
})
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 150,
        })
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local buf = event.buf
        local function lmap(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc, })
        end
        lmap("n", "grd", vim.lsp.buf.definition, "Go to definition")
        lmap("n", "grD", vim.lsp.buf.declaration, "Go to declaration")
        lmap("n", "gri", vim.lsp.buf.implementation, "Go to implementation")
        lmap("n", "grr", vim.lsp.buf.references, "References")
        lmap("n", "grt", vim.lsp.buf.type_definition, "Type definition")
        lmap("n", "K", vim.lsp.buf.hover, "Hover documentation")
        lmap("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
        lmap("n", "gra", vim.lsp.buf.code_action, "Code action")
        lmap("n", "grn", vim.lsp.buf.rename, "Rename")
        lmap("n", "<leader>lf",
            function()
                require("conform").format({ async = true, lsp_format = "fallback", })
            end, "Format buffer")
        lmap("n", "<leader>gd", vim.diagnostic.open_float, "Line diagnostics")
        lmap("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
        lmap("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
        -- Inlay hints where supported
        if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(false, { bufnr = buf })
            lmap("n", "<leader>th",
                function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
                end, "Toggle inlay hints")
        end
    end,
})


-- keymaps
vim.keymap.set("n", "<Esc>", vim.cmd.nohl)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-n>", ":cnext<CR>zz")
vim.keymap.set("n", "<C-p>", ":cprevious<CR>zz")

vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")
vim.keymap.set("n", "<A-l>", "<C-w>l")

vim.keymap.set("n", "<", "<gv")
vim.keymap.set("n", ">", ">gv")

vim.pack.add({
    "https://github.com/Mofiqul/vscode.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/catgoose/nvim-colorizer.lua",
    "https://github.com/akinsho/bufferline.nvim",
    "https://github.com/nvim-tree/nvim-tree.lua",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    -- "https://github.com/numtostr/comment.nvim",
    "https://github.com/echasnovski/mini.comment",
    "https://github.com/folke/todo-comments.nvim",
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/stevearc/Oil.nvim",
    "https://github.com/ThePrimeagen/harpoon",
    -- "https://github.com/windwp/nvim-autopairs",
    "https://github.com/linux-cultist/venv-selector.nvim",
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-path",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/saadparwaiz1/cmp_luasnip",
    "https://github.com/rafamadriz/friendly-snippets"
})

vim.keymap.set("n", "-", vim.cmd.Oil)
require("oil").setup()

vim.cmd.colorscheme("vscode")

require("bufferline").setup({
    options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
    }
})
vim.keymap.set("n", "<Tab>", vim.cmd.BufferLineCycleNext)
vim.keymap.set("n", "<S-Tab>", vim.cmd.BufferLineCyclePrev)

require("nvim-tree").setup({
    view = {
        side = "right",
        width = 30,
    },
    actions = {
        open_file = {
            quit_on_open = false
        },
    }
})
-- vim.keymap.set("n", "<leader>ee", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "\\", vim.cmd.NvimTreeToggle)

-- safe loading
-- local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
--
-- if not status_ok then
--     return
-- end

require("nvim-treesitter").setup({
    ensure_installed = {
        "bash",
        "python",
        "toml",
        "lua",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "json",
        "yaml",
        "sql",
        "http",
        "javascript",
        "typescript",
    },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
})

require("render-markdown").setup({
    heading = {
        enabled = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
    },
    code = {
        style = "full", -- Highlights code block background & borders
    },
})

require("colorizer").setup({})

require("mini.comment").setup({
    options = {
        custom_commentstring = nil,
        ignore_blank_line = false,
        start_of_line = false,
        pad_comment_parts = true,
    },
})
require("todo-comments").setup()

-- local status_ok, builtin = pcall(require,"telescope.builtin")
-- if status_ok then
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.grep_string)
vim.keymap.set("n", "<leader>fw", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>f'", builtin.registers)
vim.keymap.set("n", "<leader>fo", builtin.oldfiles)
vim.keymap.set("n", "<leader>fm", builtin.man_pages)


-- mason & lsp
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "basedpyright",
        "lua_ls",
    },
})



-- -- deprecated
-- local lspconfig = require("lspconfig")
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- lspconfig.pyright.setup({
-- 	capabilities = capabilities,
-- 	settings = {
-- 		Lua = {
-- 			diagnostics = {
-- 				globals = {
-- 					"vim"
-- 				}
-- 			}
-- 		}
-- 	}
-- })

require("venv-selector").setup({
    name = {
        "venv",
        ".venv",
    },
    auto_refresh = false,
    search = false,
    search_workspace = true,
    search_venv_managers = true,
})
vim.keymap.set("n", "<leader>vs", ":VenvSelect<CR>")
vim.keymap.set("n", "<leader>vc", ":VenvSelectCached<CR>")
vim.keymap.set("n", "<leader>vi", ":VenvSelectCurrent<CR>")


local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("basedpyright", {
    capabilities = capabilities,
    settings = {
        basedpyright = {
            analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "standard", -- "strict"
                useLibraryCodeForTypes = true,
            },
        },
    },
})

vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThisParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                },
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

vim.lsp.enable("basedpyright")
vim.lsp.enable("lua_ls")


vim.diagnostic.config({
    virtual_text = {
        spacing = 2,
        prefix = "●",
    },
    signs = true,
    underline = true,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
    },
    update_in_insert = false,
})

-- format
require("conform").setup({
    formatters_by_ft = {
        python = { "ruff_format" },
        lua = { "stylua" },
        bash = { "shfmt" },

        yaml = { "prettierd" },
        json = { "biome" },
        jsonc = { "biome" },
        markdown = { "prettierd" },

        sql = { "sqlfluff" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
    notify_on_error = true,
})

-- harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- vim.keymap.set("n", "<S-m>", mark.add_file)
-- vim.keymap.set("n", "<Tab>", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>ha", mark.add_file)
vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu)
vim.keymap.set("n", "<A-u>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<A-i>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<A-o>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<A-p>", function() ui.nav_file(4) end)
vim.keymap.set("n", "<A-y>", function() ui.nav_file(5) end)


local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
        { name = "path" },
    }),
    -- window = {
    --     completion = cmp.config.window.bordered({
    --         -- border = "rounded",
    --     }),
    --
    --     documentation = cmp.config.window.bordered({
    --         -- border = "rounded",
    --     }),
    -- }
})


-- require("nvim-autopairs").setup()
-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
