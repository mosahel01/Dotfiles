vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "west-coast-sunset"

-- Load the theme
local theme = require("colors.homegrown.themes.sunset.west-coast.west-coast-sunset")
theme.set_highlights()
