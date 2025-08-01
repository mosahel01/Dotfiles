-- Minimal ftplugin/java.lua for kickstart.nvim + nvim-jdtls

local ok, jdtls = pcall(require, 'jdtls')
if not ok then
  return
end

-- This workspace_dir must be unique per-project for full LSP power!
-- Here we use the current working directory's name to build it.
local home = vim.fn.stdpath 'data'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home .. '/jdtls_ws/' .. project_name

jdtls.start_or_attach {
  cmd = { 'jdtls' },
  root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },
  workspace_folder = workspace_dir,
}

-- Optional: Java-specific keymaps (for code actions, organize imports, etc.) -- Don't work
vim.keymap.set('n', '<leader>oi', function()
  vim.lsp.buf.code_action()
end, { buffer = true, desc = 'Organize Imports' })
vim.keymap.set('n', '<leader>rc', function()
  vim.lsp.buf.rename()
end, { buffer = true, desc = 'Rename Class' })
