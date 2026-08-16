vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

vim.g.colors_name = "hqos_dark"

-- Load the theme
local theme = require("colors.hqos.hqos_dark")
theme.set_highlights()
