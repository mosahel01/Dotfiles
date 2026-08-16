vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

vim.g.colors_name = "hqos"

-- Load the theme
local theme = require("colors.hqos.hqos")
theme.set_highlights()
