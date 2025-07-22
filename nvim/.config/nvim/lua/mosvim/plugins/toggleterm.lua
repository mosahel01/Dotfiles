return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<C-/>", function() require("toggleterm").toggle(1) end, desc = "Toggle terminal" },
  },
  config = function()
    require("toggleterm").setup({
      direction = "horizontal",
      size = function(term)
        if term.direction == "horizontal" then
          return math.floor(vim.o.lines * 0.25)  -- 25% of screen height
        end
      end,
      open_mapping = false,
      shade_terminals = true,
      persist_size = true,
      close_on_exit = false,
      on_create = function(term)
        -- Add terminal buffer navigation mappings
        vim.keymap.set("t", "<C-j>", "<Cmd>wincmd j<CR>", { buffer = term.bufnr, desc = "Move to window below" })
        vim.keymap.set("t", "<C-k>", "<Cmd>wincmd k<CR>", { buffer = term.bufnr, desc = "Move to window above" })
        vim.keymap.set("t", "<C-h>", "<Cmd>wincmd h<CR>", { buffer = term.bufnr, desc = "Move to window left" })
        vim.keymap.set("t", "<C-l>", "<Cmd>wincmd l<CR>", { buffer = term.bufnr, desc = "Move to window right" })
      end,
    })

    -- Add navigation back to terminal from other windows
    vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
    vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
    vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to window left" })
    vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to window right" })
  end,
}
