-- function ColorMyPencils(color)
-- 	color = color or "rose-pine"
-- 	vim.cmd.colorscheme(color)
--
-- 	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--
-- end
--
-- return {
--     {
--         "folke/tokyonight.nvim",
--         config = function()
--             require("tokyonight").setup({
--                 -- your configuration comes here
--                 -- or leave it empty to use the default settings
--                 style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
--                 transparent = true, -- Enable this to disable setting the background color
--                 terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
--                 styles = {
--                     -- Style to be applied to different syntax groups
--                     -- Value is any valid attr-list value for `:help nvim_set_hl`
--                     comments = { italic = false },
--                     keywords = { italic = false },
--                     -- Background styles. Can be "dark", "transparent" or "normal"
--                     sidebars = "dark", -- style for sidebars, see below
--                     floats = "dark", -- style for floating windows
--                 },
--             })
--         end
--     },
--
--     {
--         "rose-pine/neovim",
--         name = "rose-pine",
--         config = function()
--             require('rose-pine').setup({
--                 disable_background = true,
--                 -- disable_background = false,
--             })
--
--             vim.cmd("colorscheme rose-pine")
--
--             ColorMyPencils()
--         end
--     },
--
-- }





return     {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
        flavour = "mocha", -- or 'latte', 'frappe', 'macchiato'
        transparent_background = true,
        integrations = {
            telescope = true,
            which_key = true,
            treesitter = true,
            native_lsp = {
                enabled = true,
                underlines = {
                    errors = { "undercurl" },
                    hints = { "undercurl" },
                    warnings = { "undercurl" },
                    information = { "undercurl" },
                },
            },
        },
    },
    config = function(_, opts)
        require("catppuccin").setup(opts)
        vim.cmd.colorscheme("catppuccin")
    end,
}

