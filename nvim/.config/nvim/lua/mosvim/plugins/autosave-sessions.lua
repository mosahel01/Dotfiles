return {
  "rmagatti/auto-session",
  lazy = false,

  -- enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = {
      '~/',
      '/Document',
      '~/Dotfiles',
      '~/.config/nvim',
      '~/Downloads',
      '~/',
    },
    -- log-level = 'debug',
  },
  keys = {
    -- Will use Telescope or vim.ui.select picker otherwise
    { '<leader>wr', '<cmd>SessionSearch<CR>', desc = 'Session Search' },
    -- { '<leader>ws', '<cmd>SessionSave<CR>', desc = 'Save Session' },
    { '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle AutoSave' },
  },
}
