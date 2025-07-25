vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", ";", ":")

vim.keymap.set('n','<Esc>','<cmd>nohlsearch<CR>')
vim.keymap.set('n','<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list'} )

vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- better paste
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<M-h>", "<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>")
-- vim.keymap.set("n", "<M-H>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")
vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ bufnr = 0 })
end)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })



vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })





vim.keymap.set('v', '<', '<gv', { desc = "Stay in indent" } )
vim.keymap.set('v', '>', '>gv', { desc = "Stay in indent" } )



vim.keymap.set('n', '<leader>e', '$', { desc = "$ replacement" } )






-- -- Database keymaps
-- vim.keymap.set("n", "<leader>db", "<cmd>DBUIToggle<CR>", { desc = "Toggle Database UI" })
-- vim.keymap.set("n", "<leader>df", "<cmd>DBUIFindBuffer<CR>", { desc = "Find database buffer" })
-- vim.keymap.set("n", "<leader>dr", "<cmd>DBUIRenameBuffer<CR>", { desc = "Rename database buffer" })



-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'java',
--   callback = function()
--     -- LSP keymaps
--     vim.keymap.set('n', '<leader>jo', '<Cmd>lua require"jdtls".organize_imports()<CR>', {buffer = true, desc = "Organize Imports"})
--     vim.keymap.set('n', '<leader>jt', '<Cmd>lua require"jdtls".test_class()<CR>', {buffer = true, desc = "Test Class"})
--     vim.keymap.set('n', '<leader>jn', '<Cmd>lua require"jdtls".test_nearest_method()<CR>', {buffer = true, desc = "Test Nearest"})
--
--     -- Debugger keymaps
--     vim.keymap.set('n', '<leader>dc', '<Cmd>lua require"dap".continue()<CR>', {buffer = true, desc = "Debug Continue"})
--     vim.keymap.set('n', '<leader>db', '<Cmd>lua require"dap".toggle_breakpoint()<CR>', {buffer = true, desc = "Toggle Breakpoint"})
--     vim.keymap.set('n', '<leader>dui', '<Cmd>lua require"dapui".toggle()<CR>', {desc = "Toggle Debug UI"})
--   end
-- })




-- put it in $HOME/.config/nvim/lua/mos/init.lua
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   desc = 'Highlight when yanking (copying) text',
--   group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
--   callback = function()
--     vim.hl.on_yank()
--   end,
-- })


-- vim.keymap.set("n", "<leader><leader>", function()
--     vim.cmd("so")
-- end)

