return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function()
        local harpoon = require("harpoon")
        ---@diagnostic disable-next-line: missing-parameter
        harpoon:setup()
        local function map(lhs, rhs, opts)
            vim.keymap.set("n", lhs, rhs, opts or {})
        end
        map("<leader>ha", function()
            harpoon:list():add()
        end)
        map("<leader>hm", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)
        map("<a-h>", function()
            harpoon:list():select(1)
        end)
        map("<a-j>", function()
            harpoon:list():select(2)
        end)
        map("<a-k>", function()
            harpoon:list():select(3)
        end)
        map("<a-l>", function()
            harpoon:list():select(4)
        end)
        map("<a-;>", function()
            harpoon:list():select(5)
        end)
        map("<a-u>", function()
            harpoon:list():select(6)
        end)
        map("<a-i>", function()
            harpoon:list():select(7)
        end)
        map("<a-o>", function()
            harpoon:list():select(8)
        end)
        map("<a-p>", function()
            harpoon:list():select(9)
        end)
    end,
}
















--
-- -- local local_plugins = {
-- --     {
-- --         "harpoon",
-- --         dir = "~/personal/harpoon",
-- return {
--     { "theprimeagen/harpoon",
--         config = function()
--             local harpoon = require("harpoon")
--
--             harpoon:setup()
--
--             vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
--             vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
--
--             vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
--             vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
--             vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
--             vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
--         end
--         -- },
--         -- {
--         --     "vim-apm", dir = "~/personal/vim-apm",
--         --     config = function()
--         --         --[[
--     --         local apm = require("vim-apm")
--     --
--     --         apm:setup({})
--     --         vim.keymap.set("n", "<leader>apm", function() apm:toggle_monitor() end)
--     --         --]]
--         --     end
--         -- },
--     }
-- }
