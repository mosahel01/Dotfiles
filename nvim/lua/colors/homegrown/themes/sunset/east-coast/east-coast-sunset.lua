local c = require("colors.homegrown.palette")
local f = vim.api.nvim_set_hl
local theme = {}

theme.set_highlights = function()
  f(0, "Normal", { fg = c.white.azure_white, bg = c.black.russian_violet })
  f(0, "SignColumn", { fg = c.purple[1].byzantium, bg = c.black.dim_gray })

  -- Code - Tsoding style: simple and clean
  f(0, "Comment", {})
  f(0, "Variable", {})
  f(0, "String", {})
  f(0, "Character", {})
  f(0, "Number", {})
  f(0, "Float", {})
  f(0, "Boolean", {})
  f(0, "Constant", {})
  f(0, "Type", {})
  f(0, "Function", {})
  f(0, "Keyword", {})
  f(0, "Conditional", {})
  f(0, "Repeat", {})
  f(0, "Operator", {})
  f(0, "PreProc", {})
  f(0, "Include", {})
  f(0, "Exception", {})
  f(0, "StorageClass", {})
  f(0, "Structure", {})
  f(0, "Typedef", {})
  f(0, "Define", {})
  f(0, "Macro", {})
  f(0, "Debug", {})
  f(0, "Title", {})
  f(0, "Label", {})
  f(0, "SpecialChar", {})
  f(0, "Delimiter", {})
  f(0, "SpecialComment", {})
  f(0, "Tag", {})
  f(0, "Bold", {})
  f(0, "Italic", {})
  f(0, "Underlined", {})
  f(0, "Ignore", {})
  f(0, "Todo", {})
  f(0, "Error", {})
  f(0, "Statement", {})
  f(0, "Identifier", {})
  f(0, "PreCondit", {})
  f(0, "Special", {})
end

function theme.setup()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.g.colors_name = "west-coast-sunset"
  theme.set_highlights()
end

return theme
