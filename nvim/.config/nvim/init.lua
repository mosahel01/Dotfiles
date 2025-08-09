local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require 'options'
require 'keymaps'

require('lazy').setup({
    require 'mos.plugins.autopairs',
    -- require 'mos.plugins.autosave-sessions',
    require 'mos.plugins.blink-cmp',
    require 'mos.plugins.colorscheme',
    require 'mos.plugins.conform',
    require 'mos.plugins.harpoon',
    -- require 'mos.plugins.indent_line',
    require 'mos.plugins.nvim-surround',
    require 'mos.plugins.lazydev',
    require 'mos.plugins.lint',
    require 'mos.plugins.luasnip',
    require 'mos.plugins.markdown',
    require 'mos.plugins.neo-tree',
    require 'mos.plugins.nvim-lspconfig',
    require 'mos.plugins.nvim-treesitter',
    require 'mos.plugins.oil',
    require 'mos.plugins.telescope',
    require 'mos.plugins.todo-comments',
    require 'mos.plugins.treesj',
    require 'mos.plugins.undotree',
    require 'mos.plugins.which-key',
    require 'mos.plugins.zen-mode',

    -- { import = 'mos.plugins' }, -- import without having to require here manually
}, {
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
        },
    },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
