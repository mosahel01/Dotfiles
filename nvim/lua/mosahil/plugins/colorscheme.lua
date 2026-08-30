local M = {
    "wtfox/jellybeans.nvim",
    lazy = false,
    priority = 1000,
}

M.config = function()
    opts = {
        transparent = false,
        italics = true,
        bold = true,
        flat_ui = true,                  -- toggles "flat UI" for pickers
        background = {
            dark = "jellybeans-default", -- default dark palette
            light = "jellybeans_light",  -- default light palette
        },
        plugins = {
            all = false,
            auto = true, -- auto-detect installed plugins via lazy.nvim
        },
        on_highlights = function(highlights, colors) end,
        on_colors = function(colors) end,
    }
    vim.cmd.colorscheme("jellybeans")
end


return M
