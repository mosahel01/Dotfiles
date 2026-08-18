vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

opt.relativenumber = true
opt.number = true

vim.opt.fillchars = { eob = " " }
vim.opt.signcolumn = "no"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- tabs & indentations
opt.tabstop = 4 -- 4 space for tabs (prettier default)
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.softtabstop = 4

opt.tabstop = 4 -- 4 space for tabs (prettier default)
opt.shiftwidth = 4 -- 4 spaces for indent width

opt.smartindent = true
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.scrolloff = 20 -- Centers the text when you  type outside of the vertical bounds
opt.sidescrolloff = 8 -- Centers the text when you type outside of the horizontal bounds

opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in search, assumes you want case-sensitmart/ve
opt.cursorline = true
opt.hlsearch = true
opt.incsearch = true

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
--opt.background = "dark" -- colorschemes that can be light or dark will be made dark
-- opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line, or mode start of position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows

opt.splitright = true -- split veritcal window to the right
opt.splitbelow = true -- split horizontal window to the bottom

vim.cmd("hi clear")

vim.cmd("syntax on")

vim.cmd("filetype on")
