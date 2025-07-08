return {
    "nvim-telescope/telescope.nvim",
    -- Remove tag to use latest stable version
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        -- Ensure Telescope is loaded before accessing builtin
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                file_ignore_patterns = { "node_modules", "%.git" },
            },
            pickers = {
                lsp_code_actions = {
                    theme = "dropdown",
                    previewer = false,
                },
                current_buffer_fuzzy_find = {
                    theme = "dropdown",
                    previewer = false,
                },
            },
        })

        -- Load builtin after setup
        local builtin = require("telescope.builtin")

        -- Existing keymaps
        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find Files" })
        vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git Files" })
        vim.keymap.set("n", "<leader>pws", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, { desc = "Grep Word Under Cursor" })
        vim.keymap.set("n", "<leader>pWs", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end, { desc = "Grep WORD Under Cursor" })
        vim.keymap.set("n", "<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, { desc = "Grep String" })
        vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "Help Tags" })
        -- one of them is in init.lua and other is useless
        -- vim.keymap.set("n", "<leader>ca", builtin.lsp_code_actions, { desc = "Code Actions" })
        vim.keymap.set("n", "<leader>pg", builtin.live_grep, { desc = "Live Grep Project" })
        -- vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Live Grep Project" })

        -- Search within the current file
        -- if builtin.current_buffer_fuzzy_find then
            vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Search in Current File" })
        -- else
        --     vim.notify("Telescope: current_buffer_fuzzy_find not available", vim.log.levels.WARN)
        -- end
    end,
}
