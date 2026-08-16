-- Define colors
--
--
local colors = {
  -- Const colors
  WHITE = "#FFFFFF",
  BLACK = "#000000",

  -- Color sets
  mainSet = {
    BG = "#2F3F4F",
    FG = "#FFFFFF",
    MINT = "#3EB489",
  },

  altSet = {
    bg = "#2F3F4F", -- Background
    FG_GREEN = "#00a0ff",
    NAVY = "#2E5A88",
    SUNSET = "#C39C92",
    BEACH = "#BEAFAC",
    SKY = "#BDBDBD",
    SKYLINE = "#947481",
  },

  -- General Colors
  SUBTLE_BLUE = "#86b9b0",
  RED = "#8f5458",
  BRIGHTRED = "#FF0000",
  YELLOW = "#FFFF00",

  -- Comments

  -- (old one) bg = "#000000", -- Background
  bg_temp = "#005757",
  func = "#eddebc",
  main = "#FFFFFF",     -- Main color -> Light Green
  mainDeep = "#05371b", -- Deep being a darker green
  secondary = "#82EEFD", -- Secondary Color -> Light blue
  creamOrange = "#ee9d83",
  LAVENDER = "#D3D3FF",
  SUNSET_RED = "#F25C5C",
  SALMON = "#FF8C8C",
  LIGHT_GRAY = "#C7C7C7",

  -- Syntax
  string = "#000000",
  conditional = "#3ded97",
  const = "#355c7d",
  PURP = "#A23BEC",
  var = "#4dfd01",
  op = "#000000",
  DARK_GREEN = "#033500",
  comments = "#a7cffb",
}


local function setHighlight()
  local hl = vim.api.nvim_set_hl

  -- General UI
  hl(0, "Normal", { fg = colors.main, bg = colors.mainSet.bg })
  hl(0, "CursorLine", { bg = colors.bg })
  hl(0, "Visual", { bg = colors.YELLOW })
  hl(0, "LineNr", { fg = colors.SUBTLE_BLUE })
  hl(0, "CursorLineNr", { fg = colors.main })
  hl(0, "FoldColumn", { fg = colors.main })
  hl(0, "Delimiter", { fg = colors.mainDeep })
  hl(0, "Folded", { fg = colors.main })
  hl(0, "TabLine", { fg = colors.WHITE })
  hl(0, "TabLineFill", { fg = colors.WHITE })
  hl(0, "VertSplit", { fg = colors.WHITE })
  hl(0, "ModeMsg", { fg = colors.creamOrange })
  hl(0, "CmdLine", { fg = colors.WHITE })
  -- Syntax Highlighting
  -- I don't think you really do anything... hl(0, "TsVariable", { fg = colors.altSet.FG_GREEN })
  hl(0, "Comment", { fg = colors.WHITE, italic = true }) -- Comments
  hl(0, "conditional", { fg = colors.mainDeep, italic = true })
  -- this is for the variable, TODO: NEED TO FIGURE OUT SOLUTION FOR (EX) colors.mainDeep (colors) => will be secondary and (.mainDeep) will be creamOrange
  hl(0, "Operator", { fg = colors.LAVENDER })     -- For Operators (ex => <=, >=, ==, etc...)
  hl(0, "Special", { fg = colors.creamOrange })   -- Special is for the {} brackets and other things, I'm going to have to figure out :o
  hl(0, "String", { fg = colors.altSet.BEACH })   -- Obviouslly for strings
  hl(0, "Keyword", { fg = colors.altSet.SKYLINE }) -- var, int, else (in python), etc...
  hl(0, "Function", { fg = colors.SUBTLE_BLUE })  -- def, methods in java, etc
  --hl(0, "Variable", { fg = colors.DARK_GREEN })
  hl(0, "Identifier", { fg = colors.conditional })
  hl(0, "Type", { fg = colors.creamOrange })
  hl(0, "Constant", { fg = colors.altSet.SUNSET })
  hl(0, "Delimiter", { fg = colors.altSet.NAVY })
  hl(0, "Float", { fg = colors.WHITE })
  hl(0, "Boolean", { fg = colors.SUNSET_RED })
  hl(0, "Exception", { fg = colors.mainDeep })
  hl(0, "Statement", { fg = colors.SUBTLE_BLUE })
end
-- Export the colorscheme module
local M = {}

M.setup = function()
  vim.cmd("highlight clear")
  vim.cmd("syntax reset")
  vim.g.colors_name = "mytheme" -- Set the colorscheme name
  setHighlight()               -- Apply the highlights
end

return M
