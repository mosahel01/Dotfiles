-- TempleOS colorscheme for Neovim
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

vim.g.colors_name = "templeos"

-- Load the theme
local theme = require("colors.temple.templeos")
theme.set_highlights()

