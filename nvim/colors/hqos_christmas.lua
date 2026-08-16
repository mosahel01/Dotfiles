vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

vim.g.colors_name = "hqos_christmas"

-- Load the theme
local theme = require("colors.hqos.hqos_christmas")
theme.set_highlights()