local M = {}

-- State to track the floating notes buffer/window
local state = {
	notes = {
		buf = -1,
		win = -1,
		visible = false,
	},
}

-- Move the notes window to the right side of the screen
function M.move_right()
	if not vim.api.nvim_win_is_valid(state.notes.win) then
		vim.notify("Floating notes window is not open", vim.log.levels.WARN)
		return
	end
	local new_width = math.floor(vim.o.columns * 0.3)
	local new_height = vim.o.lines - 2
	local new_col = vim.o.columns - new_width
	local new_row = 0

	local cfg = vim.api.nvim_win_get_config(state.notes.win)
	cfg.width = new_width
	cfg.height = new_height
	cfg.col = new_col
	cfg.row = new_row
	vim.api.nvim_win_set_config(state.notes.win, cfg)
end

-- Create or reuse a scratch buffer in a floating window
local function open_floating_notes(opts)
	opts = opts or {}

	local width = opts.width or math.floor(vim.o.columns * 0.2)
	local height = opts.height or math.floor(vim.o.lines * 1)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2 - 1)

	-- If the buffer is valid, reuse it; otherwise create a new one
	local buf
	if vim.api.nvim_buf_is_valid(state.notes.buf) then
		buf = state.notes.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- create a scratch buffer
		vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")
		vim.api.nvim_buf_set_option(buf, "filetype", "markdown") -- optional, for syntax highlighting
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
	vim.api.nvim_win_set_option(win, "number", true)
	vim.api.nvim_win_set_option(win, "relativenumber", true)

	vim.api.nvim_set_hl(0, "MyFloatBG", { bg = "#1e222a" }) -- Your custom background color
	vim.api.nvim_set_hl(0, "MyFloatBorder", { fg = "#ff0000" }) -- Your custom border color
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

	-- Optionally jump straight into insert mode if you want:
	-- vim.cmd("startinsert")
	else
		-- If it's visible, hide it
		vim.api.nvim_win_hide(state.notes.win)
		state.notes.visible = false
	end
end

-- Move the notes window to center
function M.move_center()
	if not vim.api.nvim_win_is_valid(state.notes.win) then
		vim.notify("Floating notes window is not open", vim.log.levels.WARN)
		return
	end
	local new_width = math.floor(vim.o.columns * 0.8)
	local new_height = math.floor(vim.o.lines * 0.8)
	local new_col = math.floor((vim.o.columns - new_width) / 2)
	local new_row = math.floor((vim.o.lines - new_height) / 2 - 1)

	local cfg = vim.api.nvim_win_get_config(state.notes.win)
	cfg.width = new_width
	cfg.height = new_height
	cfg.col = new_col
	cfg.row = new_row
	vim.api.nvim_win_set_config(state.notes.win, cfg)
end

-- this function is just used for going back and forth between notes and the actual code

vim.keymap.set("n", "<leader>nn", M.toggle_notes, { desc = "[F]loating [N]otes" })
-- Keys to move the notes window around
vim.keymap.set("n", "<leader>nr", M.move_right, { desc = "Move floating notes to the right" })
vim.keymap.set("n", "<leader>nc", M.move_center, { desc = "Center floating notes window" })

-- Return empty plugin spec since this is just a utility module
return {}
