return {
  {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      -- Load ready-made VSCode snippets collection (includes Java)
      require('luasnip.loaders.from_vscode').lazy_load()

      -- If you want to load your own snippets later, you can add:
      -- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/custom/snippets" })
    end,
  },
}
