
-- Define colors
local colors = {
    -- General Colors
    WHITE = '#FFFFFF',
    BLACK = '#000000',
    RED = '#FF0000',
    bg = "#3C3D3A",
    serviceGreen = "#6ea171",
    armyBrown = "#8b864e",
    greenTurf = "#a2cd5a",
    creamOrange = "#ee9d83",
    coyoteBrown = "#bdb76b",
}

-- Define function to set highlights
local function setHighlight()
    local hl = vim.api.nvim_set_hl



  -- General UI
    hl(0, "Normal", { fg = colors.main, bg = colors.bg })
    hl(0, "CursorLine", { bg = colors.bg})
    hl(0, "Visual", { bg = colors.serviceGreen})
    hl(0, "VisualNOS", { bg = colors.coyoteBrown})
    hl(0, "LineNr", { fg = colors.serviceGreen})
    hl(0, "CursorLineNr", { fg = colors.coyoteBrown})
    hl(0, "FoldColumn", { fg = colors.serviceGreen})
    hl(0, "Folded", { fg = colors.WHITE})
    hl(0, "TabLine", { fg = colors.WHITE})
    hl(0, "TabLineFill", { fg = colors.WHITE})
    hl(0, "VertSplit", { fg = colors.WHITE})
    hl(0, "ModeMsg", { fg = colors.serviceGreen})
    hl(0, "CmdLine", { fg = colors.WHITE})
    hl(0, "PMenu", { fg = colors.WHITE})
    hl(0, "StatusLine", { fg = colors.coyoteBrown})

    -- Syntax Highlighting
    hl(0, "TsVariable", { fg = colors.armyBrown})
    hl(0, "Comment", { fg = colors.WHITE})
    hl(0, "conditional", { fg = colors.serviceGreen})
    -- this is for the variable, TODO: NEED TO FIGURE OUT SOLUTION FOR (EX) colors.mainDeep (colors) -> will be secondary and (.mainDeep) will be creamOrange 
    hl(0, "Identifier", { fg = colors.armyBrown}) -- For all var names
    hl(0, "Operator", { fg = colors.greenTurf}) -- For Operators
    hl(0, "Special", { fg = colors.coyoteBrown}) -- For Operators
    hl(0, "String", { fg = colors.greenTurf})
    hl(0, "Number", { fg = colors.creamOrange})
    hl(0, "Float", { fg = colors.creamOrange})
    hl(0, "Keyword", { fg = colors.armyBrown})
    hl(0, "Function", { fg = colors.coyoteBrown})
    hl(0, "Delimiter", { fg = colors.BLACK})
    hl(0, "MatchParen", { fg = colors.RED})
    --hl(0, "Variable", { fg = colors.creamOrange})
    hl(0, "Type", { fg = colors.creamOrange})
    --hl(0, "Constant", { fg = colors.WHITE})
    --hl(0, "Boolean", { fg = colors.WHITE})
    --hl(0, "Statement", { fg = colors.SUBTLE_BLUE})



end

-- Export the colorscheme module
local M = {}

M.setup = function()
    vim.cmd("highlight clear")
    vim.cmd("syntax reset")
    vim.g.colors_name = "military" -- Set the colorscheme name
    setHighlight() -- Apply the highlights
end

return M

