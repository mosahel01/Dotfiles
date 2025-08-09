return {
    'doums/dark.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd 'colorscheme dark'
        -- require('dark').load() {} -- Disable setting bg (make neovim's background transparent)
    end,
}
