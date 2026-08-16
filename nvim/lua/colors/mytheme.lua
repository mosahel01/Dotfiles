-- Define colors
local colors = {
	-- General Colors
	WHITE = "#FFFFFF",
	SUBTLE_BLUE = "#86b9b0",
	red = "#8f5458",

	-- GUI
	--bg = "#2d4160", -- Background
	bg = "#49407e", -- Background
	bg_temp = "#005757",
	func = "#eddebc",
	main = "#3DED97", -- Main color -> Light Green
	mainDeep = "#05371b", -- Deep being a darker green
	secondary = "#82EEFD", -- Secondary Color -> Light blue
	creamOrange = "#ee9d83",

	-- Syntax
	string = "#000000",
	conditional = "#3ded97",
	const = "#355c7d",
	var = "#4dfd01",
	op = "#000000",
	comments = "#a7cffb",
}

-- Define function to set highlights
local function setHighlight()
	local hl = vim.api.nvim_set_hl

	-- General UI
	hl(0, "Normal", { fg = colors.main, bg = colors.bg })
	hl(0, "CursorLine", { bg = colors.bg })
	hl(0, "Visual", { bg = colors.red })
	hl(0, "LineNr", { fg = colors.SUBTLE_BLUE })
	hl(0, "CursorLineNr", { fg = colors.main })
	hl(0, "FoldColumn", { fg = colors.main })
	hl(0, "Folded", { fg = colors.main })
	hl(0, "TabLine", { fg = colors.WHITE })
	hl(0, "TabLineFill", { fg = colors.WHITE })
	hl(0, "VertSplit", { fg = colors.WHITE })
	hl(0, "ModeMsg", { fg = colors.creamOrange })
	hl(0, "CmdLine", { fg = colors.WHITE })

	-- Syntax Highlighting
	--hl(0, "TsVariable", { fg = colors.const})
	hl(0, "Comment", { fg = colors.mainDeep })
	hl(0, "conditional", { fg = colors.mainDeep })
	-- this is for the variable, TODO: NEED TO FIGURE OUT SOLUTION FOR (EX) colors.mainDeep (colors) -> will be secondary and (.mainDeep) will be creamOrange
	hl(0, "Identifier", { fg = colors.secondary }) -- For all var names
	hl(0, "Operator", { fg = colors.op }) -- For Operators
	hl(0, "Special", { fg = colors.WHITE }) -- For Operators
	hl(0, "String", { fg = colors.string })
	hl(0, "Keyword", { fg = colors.conditional })
	hl(0, "Function", { fg = colors.SUBTLE_BLUE })
	hl(0, "Variable", { fg = colors.creamOrange })
	hl(0, "Type", { fg = colors.creamOrange })
	hl(0, "Constant", { fg = colors.WHITE })
	hl(0, "Float", { fg = colors.WHITE })
	hl(0, "Boolean", { fg = colors.WHITE })
	hl(0, "Statement", { fg = colors.SUBTLE_BLUE })
end

-- Export the colorscheme module
local M = {}

M.setup = function()
	vim.cmd("highlight clear")
	vim.cmd("syntax reset")
	vim.g.colors_name = "mytheme" -- Set the colorscheme name
	setHighlight() -- Apply the highlights
end

return M
