return {
    "mason-org/mason.nvim",
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    },
  config = function()
    require("mason").setup(opts)

    -- Add this to automatically install LSP servers
    require("mason-lspconfig").setup({
      ensure_installed = {
        -- "java-debug-adapter",
        -- "java-test",
        -- "jdtls", -- Add java LSP
        "ts_ls",
        "lua_ls",
        "tailwindcss",
        "cssls",
        "hyprls"
      }
    })
  end
}
