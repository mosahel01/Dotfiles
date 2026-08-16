-- Tsoding-inspired colorscheme for Neovim
-- Pure black background with white text, yellow keywords, green strings
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

vim.g.colors_name = "tsoding"

-- Load the theme
local theme = require("colors.tsoding.tsoding")
theme.set_highlights()
