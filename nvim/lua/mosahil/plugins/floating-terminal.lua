---@author { @Override } : 10:00 | 20250314

vim.o.hidden = true
vim.keymap.set("t", "<esc>", [[<c-\><c-n>]])

local state = {
	terminals = {}, -- Store terminal info per tab
}

local function get_current_tabpage()
	return vim.api.nvim_get_current_tabpage()
end

local function ensure_tab_state()
	local tab = get_current_tabpage()
	if not state.terminals[tab] then
		state.terminals[tab] = {
			buf = -1,
			win = -1,
			last_win = -1,
			visible = false,
			term_job = nil,
		}
	end
	return state.terminals[tab]
end

local function get_term_state()
	return ensure_tab_state()
end

local function cleanup_closed_tabs()
	local current_tabs = {}
	for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
		current_tabs[tabpage] = true
	end

	for tab in pairs(state.terminals) do
		if not current_tabs[tab] then
			state.terminals[tab] = nil
		end
	end
end

local function open_floating_terminal(opts)
	cleanup_closed_tabs()
	local term_state = get_term_state()

	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.8)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2 - 1)

	local buf
	if vim.api.nvim_buf_is_valid(term_state.buf) then
		buf = term_state.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")
	end

	local win_configs = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
		title = " { </$NeoVim_Terminal> } ",
		title_pos = "center",
	}
	local win = vim.api.nvim_open_win(buf, true, win_configs)

	vim.api.nvim_win_set_option(win, "wrap", false)
	vim.api.nvim_win_set_option(win, "winhl", "NormalFloat:Normal")

	return buf, win
end

local function toggle_terminal()
	local term_state = get_term_state()

	if not vim.api.nvim_win_is_valid(term_state.win) or not term_state.visible then
		local buf, win = open_floating_terminal()
		term_state.buf = buf
		term_state.win = win
		term_state.visible = true

		if
			vim.bo[buf].buftype ~= "terminal"
			or (term_state.term_job and vim.fn.jobwait({ term_state.term_job }, 0)[1] ~= -1)
		then
			term_state.term_job = vim.fn.termopen(vim.o.shell)
		end
		vim.cmd.startinsert()
	else
		-- Terminal is visible—hide it.
		vim.api.nvim_win_hide(term_state.win)
		term_state.visible = false
	end
end

local function is_window_in_current_tab(win_id)
	local current_tab = get_current_tabpage()
	local win_tab = vim.api.nvim_win_get_tabpage(win_id)
	return current_tab == win_tab
end

local function toggle_terminal_focus()
	local term_state = get_term_state()

	if not vim.api.nvim_win_is_valid(term_state.win) then
		vim.notify("Floating terminal is not open in this tab", vim.log.levels.WARN)
		return
	end

	local current_win = vim.api.nvim_get_current_win()

	if current_win == term_state.win then
		if
			term_state.last_win
			and vim.api.nvim_win_is_valid(term_state.last_win)
			and is_window_in_current_tab(term_state.last_win)
		then
			vim.api.nvim_set_current_win(term_state.last_win)
		else
			local wins = vim.api.nvim_tabpage_list_wins(get_current_tabpage())
			for _, win in ipairs(wins) do
				if win ~= term_state.win then
					vim.api.nvim_set_current_win(win)
					break
				end
			end
		end
	else
		term_state.last_win = current_win
		vim.api.nvim_set_current_win(term_state.win)
		vim.cmd("startinsert")
	end
end

local function move_terminal(position)
	local term_state = get_term_state()

	if not vim.api.nvim_win_is_valid(term_state.win) then
		vim.notify("Floating terminal is not open in this tab", vim.log.levels.WARN)
		return
	end

	local cfg = vim.api.nvim_win_get_config(term_state.win)

	if position == "right" then
		cfg.width = math.floor(vim.o.columns * 0.3)
		cfg.height = vim.o.lines - 2
		cfg.col = vim.o.columns - cfg.width
		cfg.row = 0
	elseif position == "left" then
		cfg.width = math.floor(vim.o.columns * 0.3)
		cfg.height = vim.o.lines - 2
		cfg.col = 0
		cfg.row = 0
	elseif position == "bottom" then
		cfg.width = vim.o.columns
		cfg.height = math.floor(vim.o.lines * 0.3)
		cfg.col = 0
		cfg.row = vim.o.lines - cfg.height
	elseif position == "center" then
		cfg.width = math.floor(vim.o.columns * 0.8)
		cfg.height = math.floor(vim.o.lines * 0.8)
		cfg.col = math.floor((vim.o.columns - cfg.width) / 2)
		cfg.row = math.floor((vim.o.lines - cfg.height) / 2 - 1)
	elseif position == "fullscreen" then
		cfg.width = vim.o.columns
		cfg.height = vim.o.lines - 2
		cfg.col = 0
		cfg.row = 0
	end

	vim.api.nvim_win_set_config(term_state.win, cfg)
end

vim.api.nvim_create_autocmd("BufDelete", {
	callback = function(args)
		for tab, term in pairs(state.terminals) do
			if term.buf == args.buf then
				term.buf = -1
				term.visible = false
				term.term_job = nil
			end
		end
	end,
})

vim.api.nvim_create_autocmd("WinClosed", {
	callback = function(args)
		local win_id = tonumber(args.match)
		for tab, term in pairs(state.terminals) do
			if term.win == win_id then
				term.visible = false
			end
		end
	end,
})

vim.api.nvim_create_autocmd("TabClosed", {
	callback = function()
		vim.defer_fn(cleanup_closed_tabs, 100)
	end,
})

local function setup_keymaps()
	vim.keymap.set({ "n", "t" }, "<leader>tt", toggle_terminal, { desc = "[T]oggle [T]erminal" })
	vim.keymap.set(
		{ "n", "t" },
		"<leader>tf",
		toggle_terminal_focus,
		{ desc = "Toggle focus between terminal and editor" }
	)

	vim.keymap.set({ "n", "t" }, "<leader>tr", function()
		move_terminal("right")
	end, { desc = "Move terminal right" })

	vim.keymap.set({ "n", "t" }, "<leader>tl", function()
		move_terminal("left")
	end, { desc = "Move terminal left" })

	vim.keymap.set({ "n", "t" }, "<leader>tb", function()
		move_terminal("bottom")
	end, { desc = "Move terminal bottom" })

	vim.keymap.set({ "n", "t" }, "<leader>tc", function()
		move_terminal("center")
	end, { desc = "Center terminal" })

	vim.keymap.set({ "n", "t" }, "<leader>ts", function()
		move_terminal("fullscreen")
	end, { desc = "Fullscreen terminal" })

	vim.keymap.set({ "n", "t" }, "<leader>tf", toggle_terminal_focus, { desc = "Toggle terminal focus" })

	vim.api.nvim_create_user_command("TermToggle", toggle_terminal, {})
	vim.api.nvim_create_user_command("TermFocus", toggle_terminal_focus, {})

	vim.api.nvim_create_user_command("TermRight", function()
		move_terminal("right")
	end, {})

	vim.api.nvim_create_user_command("TermLeft", function()
		move_terminal("left")
	end, {})

	vim.api.nvim_create_user_command("TermBottom", function()
		move_terminal("bottom")
	end, {})
	vim.api.nvim_create_user_command("TermCenter", function()
		move_terminal("center")
	end, {})
	vim.api.nvim_create_user_command("TermFullscreen", function()
		move_terminal("fullscreen")
	end, {})
end

setup_keymaps()
-- Return empty plugin spec since this is just a utility module
return {}
