return {
  'neovim/nvim-lspconfig',
  opts = {
    inlay_hints = { enabled = false },
    ---@type lspconfig.options
    servers = {
      cssls = {},
      tailwindcss = {
        root_dir = function(...)
          return require('lspconfig.util').root_pattern '.git'(...)
        end,
      },
      ts_ls = {
        root_dir = function(...)
          return require('lspconfig.util').root_pattern '.git'(...)
        end,
        single_file_support = false,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'literal',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      },
      html = {},
      yamlls = {
        settings = {
          yaml = {
            keyOrdering = false,
          },
        },
      },
      lua_ls = {
        -- enabled = false,
        single_file_support = true,
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              workspaceWord = true,
              callSnippet = 'Both',
            },
            misc = {
              parameters = {
                -- "--log-level=trace",
              },
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = 'Disable',
              semicolon = 'Disable',
              arrayIndex = 'Disable',
            },
            doc = {
              privateName = { '^_' },
            },
            type = {
              castNumberToInteger = true,
            },
            diagnostics = {
              disable = { 'incomplete-signature-doc', 'trailing-space' },
              -- enable = false,
              groupSeverity = {
                strong = 'Warning',
                strict = 'Warning',
              },
              groupFileStatus = {
                ['ambiguity'] = 'Opened',
                ['await'] = 'Opened',
                ['codestyle'] = 'None',
                ['duplicate'] = 'Opened',
                ['global'] = 'Opened',
                ['luadoc'] = 'Opened',
                ['redefined'] = 'Opened',
                ['strict'] = 'Opened',
                ['strong'] = 'Opened',
                ['type-check'] = 'Opened',
                ['unbalanced'] = 'Opened',
                ['unused'] = 'Opened',
              },
              unusedLocalExclude = { '_*' },
            },
            format = {
              enable = false,
              defaultConfig = {
                indent_style = 'space',
                indent_size = '2',
                continuation_indent_size = '2',
              },
            },
          },
        },
      },
      -- },
      setup = {},
    },
    {
      'neovim/nvim-lspconfig',
      opts = function()
        local keys = require('lazyvim.plugins.lsp.keymaps').get()
        vim.list_extend(keys, {
          {
            'gd',
            function()
              -- DO NOT RESUSE WINDOW
              require('telescope.builtin').lsp_definitions { reuse_win = false }
            end,
            desc = 'Goto Definition',
            has = 'definition',
          },
        })
      end,
    },
  --   {
  --     'hrsh7th/nvim-cmp',
  --     version = false, -- last release is way too old
  --     event = 'InsertEnter',
  --     dependencies = {
  --       'hrsh7th/cmp-nvim-lsp',
  --       'hrsh7th/cmp-buffer',
  --       'hrsh7th/cmp-path',
  --       'rafamadriz/friendly-snippets',
  --       'abeldekat/cmp-mini-snippets',
  --     },
  --     -- Not all LSP servers add brackets when completing a function.
  --     -- To better deal with this, LazyVim adds a custom option to cmp,
  --     -- that you can configure. For example:
  --     --
  --     -- ```lua
  --     -- opts = {
  --     --   auto_brackets = { "python" }
  --     -- }
  --     -- ```
  --     opts = function()
  --       vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
  --       local cmp = require 'cmp'
  --       local defaults = require 'cmp.config.default'()
  --       local auto_select = true
  --       return {
  --         auto_brackets = {}, -- configure any filetype to auto add brackets
  --         completion = {
  --           completeopt = 'menu,menuone,noinsert' .. (auto_select and '' or ',noselect'),
  --         },
  --         preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
  --         mapping = cmp.mapping.preset.insert {
  --           ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  --           ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --           -- ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
  --           -- ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
  --           -- ['<C-Space>'] = cmp.mapping.complete(),
  --           -- ['<CR>'] = LazyVim.cmp.confirm { select = auto_select },
  --           -- ['<C-y>'] = LazyVim.cmp.confirm { select = true },
  --           -- ['<S-CR>'] = LazyVim.cmp.confirm { behavior = cmp.ConfirmBehavior.Replace }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --           -- ['<C-CR>'] = function(fallback)
  --           --   cmp.abort()
  --           --   fallback()
  --           -- end,
  --           -- ['<tab>'] = function(fallback)
  --           --   return LazyVim.cmp.map({ 'snippet_forward', 'ai_accept' }, fallback)()
  --           -- end,
  --         },
  --         sources = cmp.config.sources({
  --           { name = 'lazydev' },
  --           { name = 'nvim_lsp' },
  --           { name = 'path' },
  --         }, {
  --           { name = 'buffer' },
  --         }),
  --         formatting = {
  --           format = function(entry, item)
  --             local icons = LazyVim.config.icons.kinds
  --             if icons[item.kind] then
  --               item.kind = icons[item.kind] .. item.kind
  --             end
  --
  --             local widths = {
  --               abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
  --               menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
  --             }
  --
  --             for key, width in pairs(widths) do
  --               if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
  --                 item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. '…'
  --               end
  --             end
  --
  --             return item
  --           end,
  --         },
  --         experimental = {
  --           -- only show ghost text when we show ai completions
  --           ghost_text = vim.g.ai_cmp and {
  --             hl_group = 'CmpGhostText',
  --           } or false,
  --         },
  --         sorting = defaults.sorting,
  --       }
  --     end,
  --     main = 'lazyvim.util.cmp',
  --   },
  -- },
}
