local M = {}

-- State to track the floating notes buffer/window
local state = {
	notes = {
		buf = -1,
		win = -1,
		visible = false,
	},
}

-- Create or reuse a scratch buffer in a floating window on the RIGHT
local function open_floating_notes()
	-- Calculate dimensions for the right-hand side (30% width, full height)
	local width = math.floor(vim.o.columns * 0.3)
	local height = vim.o.lines - 2
	local col = vim.o.columns - width
	local row = 0

	-- If the buffer is valid, reuse it; otherwise create a new one
	local buf
	if vim.api.nvim_buf_is_valid(state.notes.buf) then
		buf = state.notes.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- create a scratch buffer
		vim.api.nvim_set_option_value("bufhidden", "hide", { buf = buf })
		vim.api.nvim_set_option_value("filetype", "markdown", { buf = buf })
	end

	-- Configure the floating window
	local win_configs = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	}
	local win = vim.api.nvim_open_win(buf, true, win_configs)

	vim.api.nvim_set_option_value("number", true, { win = win })
	vim.api.nvim_set_option_value("relativenumber", true, { win = win })

	vim.api.nvim_set_hl(0, "MyFloatBG", { bg = "#1e222a" })
	vim.api.nvim_set_hl(0, "MyFloatBorder", { fg = "#ff0000" })

	return buf, win
end

-- Toggle showing/hiding the floating notes window
function M.toggle_notes()
	-- If the window doesn't exist or isn't visible, show it
	if not vim.api.nvim_win_is_valid(state.notes.win) or not state.notes.visible then
		local buf, win = open_floating_notes()
		state.notes.buf = buf
		state.notes.win = win
		state.notes.visible = true
	else
		-- If it's visible, hide it
		vim.api.nvim_win_hide(state.notes.win)
		state.notes.visible = false
	end
end

-- -- Move the notes window to center (kept for utility)
-- function M.move_center()
-- 	if not vim.api.nvim_win_is_valid(state.notes.win) then
-- 		vim.notify("Floating notes window is not open", vim.log.levels.WARN)
-- 		return
-- 	end
-- 	local new_width = math.floor(vim.o.columns * 0.8)
-- 	local new_height = math.floor(vim.o.lines * 0.8)
-- 	local new_col = math.floor((vim.o.columns - new_width) / 2)
-- 	local new_row = math.floor((vim.o.lines - new_height) / 2 - 1)
--
-- 	local cfg = vim.api.nvim_win_get_config(state.notes.win)
-- 	cfg.width = new_width
-- 	cfg.height = new_height
-- 	cfg.col = new_col
-- 	cfg.row = new_row
-- 	vim.api.nvim_win_set_config(state.notes.win, cfg)
-- end

-- Keymaps
vim.keymap.set("n", "<leader>nn", M.toggle_notes, { desc = "[F]loating [N]otes" })

return {}
