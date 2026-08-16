vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "midnight-coder"

-- Load the theme
local theme = require("colors.homegrown.themes.midnight-coder.midnight-coder")
theme.set_highlights()
