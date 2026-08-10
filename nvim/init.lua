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
vim.o.smartindent = true

vim.o.hlsearch = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.ignorecase = true

vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"



-- keymaps
vim.keymap.set("n", "<Esc>", vim.cmd.nohl)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")
vim.keymap.set("n", "<A-l>", "<C-w>l")

vim.pack.add({
    "https://github.com/Mofiqul/vscode.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/akinsho/bufferline.nvim",
    "https://github.com/nvim-tree/nvim-tree.lua",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/numToStr/Comment.nvim",
    "https://github.com/folke/todo-comments.nvim",
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/stevearc/Oil.nvim",
    "https://github.com/ThePrimeagen/harpoon",
    -- "https://github.com/windwp/nvim-autopairs",
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
vim.keymap.set("n", "<leader>ee", vim.cmd.NvimTreeToggle)



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
        "lua",
        "vim",
        "vimdoc",
    },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
})

require("todo-comments").setup()
require("Comment").setup()

-- local status_ok, builtin = pcall(require,"telescope.builtin")
-- if status_ok then
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.grep_string)
vim.keymap.set("n", "<leader>fw", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)


-- mason & lsp
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "pyright",
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




local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config.pyright = {
    capabilities = capabilities,
}
vim.lsp.config.lua_ls = {
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } }
        }
    }
}
vim.lsp.enable("pyright")
vim.lsp.enable("lua_ls")


-- format
require("conform").setup({
    formatters_by_ft = {
        python = { "ruff_format" },
        lua = { "stylua" },
        bash = { "shfmt" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    }
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
})


-- require("nvim-autopairs").setup()
-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
