local colors = {
	-- GUI Colors
	main = {
		b = "#883000", -- b: Background (#88300 -> dark orange color)
		f = "#ffd22b", -- f: Foreground (#ffd22b -> Bright orange)
		ops = "#fefae0", -- ops: Operators (#585123 -> should hypothetically be green)
		func = "#eec170", -- func: Functions (#eec170 -> supposibly yellowish)
		conditionals = "",
		loops = "#c9ce10",
		something = "#585123", -- ops: Operators (#585123 -> should hypothetically be green)
	},
	cursor = "#000000",
	carot = "#",

	-- Syntax Colors
	funcName = "#ffffff",
	var = "#ff8503",
	conditional = "#000000",
	func = "#700e01", -- Dark orange
}

local function setHighlight()
	local hl = vim.api.nvim_set_hl

	-- GUI
	hl(0, "Normal", { fg = colors.fg, bg = colors.main.b })
	hl(0, "Comment", { fg = colors.fg, italic = true })

	-- Syntax
	hl(0, "Identifier", { fg = colors.var })
	hl(0, "Function", { fg = colors.main.func })
	--hl(0, "Conditional", { fg = colors.var })
	hl(0, "Type", { fg = colors.var })
	hl(0, "Conditional", { fg = colors.conditional })
	hl(0, "Statement", { fg = colors.func })
	hl(0, "String", { fg = colors.var })
	hl(0, "Operator", { fg = colors.main.ops })
	hl(0, "Special", { fg = colors.main.ops })
	hl(0, "Keyword", { fg = colors.main.loops })
end

local M = {}

M.setup = function()
	vim.cmd("highlight clear")
	vim.cmd("syntax reset")
	vim.g.colors_name = "fallguy"
	setHighlight()
end

return M
