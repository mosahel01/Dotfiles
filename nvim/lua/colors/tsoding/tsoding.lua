local c = require("colors.tsoding.tsoding-palette")

local hl = vim.api.nvim_set_hl
local theme = {}

theme.set_highlights = function()
  -- Editor
  hl(0, "Normal", { fg = c.fg, bg = c.bg })
  hl(0, "SignColumn", { fg = "NONE", bg = c.bg })
  hl(0, "MsgArea", { fg = c.fg, bg = c.bg })
  hl(0, "ModeMsg", { fg = c.fg, bg = c.alt_bg })
  hl(0, "MsgSeparator", { fg = c.fg, bg = c.bg })
  hl(0, "SpellBad", { fg = "NONE", bg = "NONE", sp = c._red, undercurl = true })
  hl(0, "SpellCap", { fg = "NONE", bg = "NONE", sp = c._yellow, undercurl = true })
  hl(0, "SpellLocal", { fg = "NONE", bg = "NONE", sp = c._green, underline = true })
  hl(0, "SpellRare", { fg = "NONE", bg = "NONE", sp = c._red, underline = true })
  hl(0, "NormalNC", { fg = c.fg, bg = c.bg })
  hl(0, "Pmenu", { fg = c.fg, bg = c.alt_bg })
  hl(0, "PmenuSel", { fg = c.bg, bg = c.alt_fg })
  hl(0, "WildMenu", { fg = c.bg, bg = c.alt_fg })
  hl(0, "CursorLine", { fg = "NONE", bg = c.cursorline })
  hl(0, "CursorLineNr", { fg = c.alt_fg, bg = "NONE", bold = true })
  hl(0, "Folded", { fg = c._grey_dark, bg = c.cursorline })
  hl(0, "FoldColumn", { fg = c._grey_dark, bg = c.bg })
  hl(0, "LineNr", { fg = c._grey_dark, bg = "NONE" })
  hl(0, "FloatBorder", { fg = c.alt_fg, bg = c.alt_bg })
  hl(0, "Whitespace", { fg = c.cursorline, bg = "NONE" })
  hl(0, "VertSplit", { fg = c._grey_dark, bg = c.bg })
  hl(0, "CursorColumn", { fg = "NONE", bg = c.cursorline })
  hl(0, "ColorColumn", { fg = "NONE", bg = c.cursorline })
  hl(0, "NormalFloat", { fg = c.fg, bg = c.alt_bg })
  hl(0, "Visual", { fg = "NONE", bg = c.selection_bg })
  hl(0, "VisualNOS", { fg = "NONE", bg = c.cursorline })
  hl(0, "WarningMsg", { fg = c._red, bg = c.bg })
  hl(0, "DiffText", { fg = c.bg, bg = c._red })
  hl(0, "DiffAdd", { fg = c._green, bg = c._green_light })
  hl(0, "DiffChange", { fg = c._yellow, bg = c.alt_bg, underline = true })
  hl(0, "DiffDelete", { fg = c._red, bg = c.alt_bg })
  hl(0, "QuickFixLine", { fg = "NONE", bg = c.cursorline })
  hl(0, "PmenuSbar", { fg = "NONE", bg = c.cursorline })
  hl(0, "PmenuThumb", { fg = "NONE", bg = c._grey_dark })
  hl(0, "MatchWord", { fg = "NONE", bg = "NONE", underline = true })
  hl(0, "MatchParen", { fg = "NONE", bg = c.bracket_match, bold = true })
  hl(0, "MatchWordCur", { fg = "NONE", bg = "NONE", underline = true })
  hl(0, "MatchParenCur", { fg = "NONE", bg = "NONE", underline = true })
  hl(0, "Cursor", { fg = c.bg, bg = c._yellow })
  hl(0, "lCursor", { fg = c.bg, bg = c._yellow })
  hl(0, "CursorIM", { fg = c.bg, bg = c._yellow })
  hl(0, "guicursor", { fg = c._yellow, bg = "NONE" })
  hl(0, "TermCursor", { fg = c.bg, bg = c.cursor_bg })
  hl(0, "TermCursorNC", { fg = c.bg, bg = c.cursor_bg })
  hl(0, "Conceal", { fg = c._grey_dark, bg = "NONE" })
  hl(0, "Directory", { fg = c._green, bg = "NONE" })
  hl(0, "SpecialKey", { fg = c.alt_fg, bg = "NONE", bold = true })
  hl(0, "ErrorMsg", { fg = c._red, bg = c.bg, bold = true })
  hl(0, "Search", { fg = "NONE", bg = c.find_match })
  hl(0, "IncSearch", { fg = "NONE", bg = c.find_match })
  hl(0, "Substitute", { fg = c.bg, bg = c._yellow })
  hl(0, "MoreMsg", { fg = c._yellow, bg = "NONE" })
  hl(0, "Question", { fg = c._yellow, bg = "NONE" })
  hl(0, "EndOfBuffer", { fg = c.bg, bg = "NONE" })
  hl(0, "NonText", { fg = c.cursorline, bg = "NONE" })
  hl(0, "TabLine", { fg = c._grey_dark, bg = c.line })
  hl(0, "TabLineSel", { fg = c.fg, bg = c.bg })
  hl(0, "TabLineFill", { fg = c.line, bg = c.line })

  -- Code - Tsoding style: simple and clean
  hl(0, "Comment", { fg = c._grey_dark, bg = "NONE", italic = true })
  hl(0, "Variable", { fg = c.fg, bg = "NONE" })
  hl(0, "String", { fg = c._green, bg = "NONE" })       -- Green strings like tsoding
  hl(0, "Character", { fg = c._green, bg = "NONE" })
  hl(0, "Number", { fg = c.fg, bg = "NONE" })           -- Keep numbers simple
  hl(0, "Float", { fg = c.fg, bg = "NONE" })
  hl(0, "Boolean", { fg = c._yellow, bg = "NONE" })     -- Yellow for keywords
  hl(0, "Constant", { fg = c.fg, bg = "NONE" })
  hl(0, "Type", { fg = c._type_color, bg = "NONE" })    -- Types use new color from theme
  hl(0, "Function", { fg = c.fg, bg = "NONE" })         -- Keep functions simple
  hl(0, "Keyword", { fg = c._yellow, bg = "NONE" })     -- Yellow keywords
  hl(0, "Conditional", { fg = c._yellow, bg = "NONE" }) -- Yellow conditionals
  hl(0, "Repeat", { fg = c._yellow, bg = "NONE" })      -- Yellow loops
  hl(0, "Operator", { fg = c.fg, bg = "NONE" })
  hl(0, "PreProc", { fg = c._yellow, bg = "NONE" })     -- Yellow preprocessor
  hl(0, "Include", { fg = c._yellow, bg = "NONE" })
  hl(0, "Exception", { fg = c._yellow, bg = "NONE" })
  hl(0, "StorageClass", { fg = c._type_color, bg = "NONE" })
  hl(0, "Structure", { fg = c._type_color, bg = "NONE" })
  hl(0, "Typedef", { fg = c._type_color, bg = "NONE" })
  hl(0, "Define", { fg = c._yellow, bg = "NONE" })
  hl(0, "Macro", { fg = c._type_color, bg = "NONE" }) -- Macros use type color
  hl(0, "Debug", { fg = c._red, bg = "NONE" })
  hl(0, "Title", { fg = c.alt_fg, bg = "NONE", bold = true })
  hl(0, "Label", { fg = c.fg, bg = "NONE" })
  hl(0, "SpecialChar", { fg = c._green, bg = "NONE" })
  hl(0, "Delimiter", { fg = c.fg, bg = "NONE" })
  hl(0, "SpecialComment", { fg = c._grey_dark, bg = "NONE", italic = true })
  hl(0, "Tag", { fg = c.alt_fg, bg = "NONE" })
  hl(0, "Bold", { fg = "NONE", bg = "NONE", bold = true })
  hl(0, "Italic", { fg = "NONE", bg = "NONE", italic = true })
  hl(0, "Underlined", { fg = "NONE", bg = "NONE", underline = true })
  hl(0, "Ignore", { fg = c._grey_dark, bg = "NONE" })
  hl(0, "Todo", { fg = c._yellow, bg = "NONE", bold = true })
  hl(0, "Error", { fg = c._red, bg = "NONE", bold = true })
  hl(0, "Statement", { fg = c._yellow, bg = "NONE" }) -- Yellow statements
  hl(0, "Identifier", { fg = c.fg, bg = "NONE" })
  hl(0, "PreCondit", { fg = c._yellow, bg = "NONE" })
  hl(0, "Special", { fg = c.fg, bg = "NONE" })

  -- Additional editor highlights for better VS Code theme match
  hl(0, "CurSearch", { fg = "NONE", bg = c.find_match })
  hl(0, "WordUnderCursor", { fg = "NONE", bg = c.word_highlight })
  hl(0, "LspReferenceText", { fg = "NONE", bg = c.word_highlight })
  hl(0, "LspReferenceRead", { fg = "NONE", bg = c.word_highlight })
  hl(0, "LspReferenceWrite", { fg = "NONE", bg = c.word_highlight })

  -- Namespace highlighting
  hl(0, "Namespace", { fg = c._namespace, bg = "NONE" })
  hl(0, "@namespace", { fg = c._namespace, bg = "NONE" })

  -- Telescope
  hl(0, "TelescopeSelection", { fg = "NONE", bg = c.cursorline })
  hl(0, "TelescopeSelectionCaret", { fg = c._yellow, bg = c.cursorline })
  hl(0, "TelescopeMatching", { fg = c._yellow, bg = "NONE", bold = true })
  hl(0, "TelescopeBorder", { fg = c._grey_dark, bg = "NONE" })
  hl(0, "TelescopeNormal", { fg = c.fg, bg = c.alt_bg })
  hl(0, "TelescopePromptTitle", { fg = c._white, bg = "NONE" })
  hl(0, "TelescopePromptPrefix", { fg = c._yellow, bg = "NONE" })
  hl(0, "TelescopeResultsTitle", { fg = c._white, bg = "NONE" })
  hl(0, "TelescopePreviewTitle", { fg = c._green, bg = "NONE" })
  hl(0, "TelescopePromptCounter", { fg = c._grey_dark, bg = "NONE" })
  hl(0, "TelescopePreviewHyphen", { fg = c._grey_dark, bg = "NONE" })

  -- Language specific - keeping it minimal like tsoding
  hl(0, "xmlTag", { fg = c._yellow, bg = "NONE" })
  hl(0, "xmlTagName", { fg = c._yellow, bg = "NONE" })
  hl(0, "xmlEndTag", { fg = c._yellow, bg = "NONE" })
  hl(0, "yamlPlainScalar", { fg = c._green, bg = "NONE" })
  hl(0, "yamlTSField", { fg = c._yellow, bg = "NONE" })
  hl(0, "luaFunc", { fg = c.fg, bg = "NONE" })
  hl(0, "luaFunction", { fg = c._yellow, bg = "NONE" })
  hl(0, "htmlTag", { fg = c._yellow, bg = "NONE" })
  hl(0, "htmlTagN", { fg = c._yellow, bg = "NONE" })
  hl(0, "htmlTagName", { fg = c._yellow, bg = "NONE" })
  hl(0, "htmlComment", { fg = c._grey_dark, bg = "NONE", italic = true })
  hl(0, "jsonKeyword", { fg = c._yellow, bg = "NONE" })

  -- Markdown - simple highlighting
  hl(0, "markdownH1", { fg = c._yellow, bg = "NONE", bold = true })
  hl(0, "markdownH2", { fg = c._yellow, bg = "NONE", bold = true })
  hl(0, "markdownH3", { fg = c._yellow, bg = "NONE", bold = true })
  hl(0, "markdownCode", { fg = c._green, bg = "NONE" })
  hl(0, "markdownCodeBlock", { fg = c._green, bg = "NONE" })
  hl(0, "markdownBold", { fg = c.fg, bg = "NONE", bold = true })
  hl(0, "markdownItalic", { fg = c.fg, bg = "NONE", italic = true })
end

function theme.setup()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.g.colors_name = "tsoding"

  -- Set cursor to be yellow caret
  vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr:hor20-Cursor,o:hor50-Cursor"

  theme.set_highlights()
end

return theme
