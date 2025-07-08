return {
    "Wansmer/treesj",
    keys = {
        -- { '<leader>tuj', function() require('treesj').join() end, desc = 'Join node' },
        -- { '<leader>tus', function() require('treesj').split() end, desc = 'Split node' },
        {
            "<leader>tu",
            function()
                require("treesj").toggle()
            end,
            desc = "Toggle node",
        },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("treesj").setup({})
    end,
}

