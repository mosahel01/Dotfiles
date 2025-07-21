return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
      git = {
        enable = true,
        ignore = false,
      },
      view = {
        width = 40,
        side = "right",
      },
    },
  },
}
