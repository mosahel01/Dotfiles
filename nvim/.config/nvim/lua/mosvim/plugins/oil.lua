return {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    -- require("oil").setup({
    --     default_file_explorer = true,
    --     skip_confirm_for_simple_edits = true,
    --     view_options = {
    --         show_hidden = true,
    --         is_always_hidden = function (name, _)
    --             return name == ".." or name == ".git"
    --         end,
    --     },
    --     keymaps = {
    --         [""] = false,
    --         ["q"] = "actions.close",
    --     }
    -- })
}
