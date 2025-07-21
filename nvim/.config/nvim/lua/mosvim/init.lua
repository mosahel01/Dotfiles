require("mosvim.set")
require("mosvim.remap")
require("mosvim.lazy")

local augroup = vim.api.nvim_create_augroup
local mos_group = augroup("mosvim", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

-- Reload remap module
-- it would hot-reload specific lua module
-- function R(name)
--     require("plenary.reload").reload_module(name)
-- end

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

-- Remove whitespace on BufWritePre ( before saving a buffer/file )
autocmd({ "BufWritePre" }, {
	group = mos_group,
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "markdown" then
			return
		end
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})
