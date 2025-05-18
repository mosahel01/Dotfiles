vim.g.mapleader = " "

-- Better line start/end movement
vim.keymap.set({ "n", "i", "v" }, "<C-h>", function()
  vim.cmd("normal! ^")
end, { desc = "Go to start of line (non-blank)" })
vim.keymap.set({ "n", "i", "v" }, "<C-S-h>", "<Home>", { desc = "Go to absolute start of line" })

-- Delete without yanking
-- vim.keymap.set({ "n", "x" }, "d", '"_d', { desc = "Delete without yanking" })
-- vim.keymap.set({ "n", "x" }, "D", '"_D', { desc = "Delete line without yanking" })
-- vim.keymap.set({ "n", "x" }, "x", '"_x', { desc = "Delete char without yanking" })
-- vim.keymap.set({ "n", "x" }, "X", '"_X', { desc = "Delete prev char without yanking" })

-- Delete word backwards (cursor must be after the word)
vim.keymap.set("n", "db", 'vb"_d', { desc = "Delete word backwards without yanking" })

vim.keymap.set("n", "<leader>pv", "<cmd>Ex<CR>")

-- Normal/Insert/Visual mode quality-of-life mappings
vim.keymap.set("n", ";", ":", { desc = "CMD enter command mode" })
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Move selected lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line up" })

-- Clear search highlights
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Smooth cursor movements
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines but stay in place" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next match centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev match centered" })

-- Replace word under cursor globally
vim.keymap.set(
  "n",
  "<leader>ss",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Substitute word under cursor" }
)

-- Make file executable
vim.keymap.set("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Paste without overwriting register
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over without yanking" })

-- Disable annoying Ex mode
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex mode" })

-- Tmux integrations
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Tmux sessionizer" })
vim.keymap.set("n", "<leader>tmux", function()
  local session_name = vim.fn.input("Session Name: ")
  vim.cmd("silent !tmux new-session -d -s " .. session_name .. " && tmux attach-session -t " .. session_name)
end, { desc = "Create and attach tmux session" })

-- Format current buffer
vim.keymap.set("n", "<leader>mf", vim.lsp.buf.format, { desc = "LSP format buffer" })

-- Delete without yanking (leader d)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

-- Increment/Decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize split sizes" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- (Optional) Tab management (uncomment if you use tabs)
-- vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
-- vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
-- vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next tab" })
-- vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Previous tab" })
-- vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current file in new tab" })


-- QuickFix Bindings
vim.keymap.set("n", "<leader>qj", "<cmd>cnext<cr>zz")
vim.keymap.set("n", "<leader>qk", "<cmd>cnext<cr>zz")
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<cr>zz")

-- These mappings control the size of splits (height/width)
vim.keymap.set("n", "<M-,>", "<c-w>5<")
vim.keymap.set("n", "<M-.>", "<c-w>5>")
vim.keymap.set("n", "<M-t>", "<C-W>+")
vim.keymap.set("n", "<M-s>", "<C-W>-")






-- theprimeagen keymaps

-- vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
--
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
--
-- vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")
--
-- vim.keymap.set("n", "<leader>vwm", function()
--     require("vim-with-me").StartVimWithMe()
-- end)
-- vim.keymap.set("n", "<leader>svwm", function()
--     require("vim-with-me").StopVimWithMe()
-- end)
--
-- -- greatest remap ever
-- vim.keymap.set("x", "<leader>p", [["_dP]])
--
-- -- next greatest remap ever : asbjornHaland
-- vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])
--
-- vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
--
-- -- This is going to get me cancelled
-- vim.keymap.set("i", "<C-c>", "<Esc>")
--
-- vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
--
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
--
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
--
-- vim.keymap.set(
--     "n",
--     "<leader>ee",
--     "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
-- )
--
-- vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");
-- vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");
--
-- vim.keymap.set("n", "<leader><leader>", function()
--     vim.cmd("so")
-- end)

