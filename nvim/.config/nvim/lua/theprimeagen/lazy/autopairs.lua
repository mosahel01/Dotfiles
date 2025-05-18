return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/nvim-cmp",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local autopairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    local ts_conds = require("nvim-autopairs.ts-conds")

    autopairs.setup({
      check_ts = true,
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
        javascriptreact = { "template_string", "jsx_element" },
        typescript = { "template_string" },
        typescriptreact = { "template_string", "tsx_element" },
        java = false,
      },
      fast_wrap = {
        map = "<M-e>", -- Alt+e for fast wrapping
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,%.%s]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
      },
    })

    -- Add JSX/TSX tag auto-closing
    autopairs.add_rules({
      Rule("<", ">", { "javascriptreact", "typescriptreact" })
        :with_pair(ts_conds.is_ts_node({ "jsx_opening_element", "tsx_opening_element" }))
        :with_move(function(opts) return opts.char == ">" end),
    })

    -- CMP integration
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}

