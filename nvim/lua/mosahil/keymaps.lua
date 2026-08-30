vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
--local state = vim.api.nvim_get_current_tabpage()
--local conf = vim.api.nvim_win_get_config(state)

--keymap.set("i", "<leader>o", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "-", vim.cmd.Ex, { desc = "Netrw" })
keymap.set("n", "<leader>sw", function()
    local new_sw = vim.o.shiftwidth == 2 and 4 or 2
    vim.o.shiftwidth = new_sw
    vim.o.tabstop = new_sw
    vim.o.softtabstop = new_sw
    print("shiftwidth set to " .. new_sw)
end, { desc = "Toggle shiftwidth between 2 and 4" })

-- Better Center
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("n", "<A-h>", "<C-w>h")
keymap.set("n", "<A-j>", "<C-w>j")
keymap.set("n", "<A-k>", "<C-w>k")
keymap.set("n", "<A-l>", "<C-w>l")

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Increment/Decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- Increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- Decrement

-- looking up keymappings real quick so this just gonna be boring for you rn.. :/ one sec
-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "[S]plit window [V]ertically" })    -- show window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "[S]plit window [H]orizontally" })  -- show window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "[S]plits size [E]qually" })        -- makes split windows equal width
keymap.set("n", "<leader>sc", "<cmd>close<CR>", { desc = "[S]plit window [C]lose" }) -- closes the current split window
--[[
keymap.set("n", "<leader>sm", function()
	conf.width = math.floor(vim.o.columns * 0.3)
	conf.height = math.floor(vim.o.lines * 0.8)
end, { desc = "[S]creen [M]aximize" })
]]

-- Switch between windows
keymap.set("n", "<leader>vn", "<cmd>windo wincmd k<CR>", { desc = " [V]iew [N]ext" })
keymap.set("n", "<leader>vb", "<cmd>windo wincmd h<CR>", { desc = " [V]iew [B]ack" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "[T]ab [O]pen (new)" })               -- opens a new tab
keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "[T]ab [C]lose" })                  -- closes current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "[T]ab [N]ext -> (right)" })            -- go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "[T]left ab [P]revious <- (left)" })    -- go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --

-- Indentation
keymap.set("v", "<", "<gv", { desc = "Indent left in visual mode." })
keymap.set("v", ">", ">gv", { desc = "Indent right in visual mode." })

-- Image Preview
keymap.set("n", "<leader>ip", "<cmd>ImagePreview<CR>", { desc = "[I]mage [P]review" })
keymap.set("n", "<leader>iw", "<cmd>ImagePreviewWeb<CR>", { desc = "[I]mage preview [W]eb" })
keymap.set("n", "<leader>it", "<cmd>ImagePreviewTerminal<CR>", { desc = "[I]mage preview [T]erminal" })

-- keymap.set("n", "<leader>nt", function()
-- 	-- Opens a tmux popup on the far right (30% width) editing a persistent notes file
-- 	-- The popup automatically closes when you exit this nested Neovim instance (using :q)
-- 	vim.fn.system([[tmux display-popup -E -w 30% -h 100% -x 100% -y 0 "nvim ~/quick-notes.md"]])
-- end, { desc = "Tmux Quick Notes" })
