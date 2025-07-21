return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local jdtls = require("jdtls")
      local config = {
        cmd = {
          'java',
          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xms1g',
          '--add-modules=ALL-SYSTEM',
          '--add-opens', 'java.base/java.util=ALL-UNNAMED',
          '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
          '-jar', vim.fn.glob(vim.fn.stdpath('data') .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
          '-configuration', vim.fn.stdpath('data') .. '/mason/packages/jdtls/config_linux',
          '-data', vim.fn.expand('~/.java-workspace')
        },
        root_dir = require('jdtls.setup').find_root({'.git', 'build.gradle', 'pom.xml'}),
        settings = {
          java = {
            signatureHelp = { enabled = true },
            completion = {
              favoriteStaticMembers = {
                "org.junit.Assert.*",
                "org.junit.jupiter.api.Assertions.*",
                "org.mockito.Mockito.*"
              }
            }
          }
        },
      }

      -- Attach JDTLS
      require('jdtls').start_or_attach(config)

      -- Java-specific keymaps
      vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, {desc = "Organize Imports"})
      vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, {desc = "Extract Variable"})
      vim.keymap.set("v", "<leader>jm", function() jdtls.extract_method(true) end, {desc = "Extract Method"})
      vim.keymap.set("n", "<leader>jc", jdtls.test_class, {desc = "Test Class"})
      vim.keymap.set("n", "<leader>jn", jdtls.test_nearest_method, {desc = "Test Nearest Method"})
    end
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end
    },
    config = function()
      -- Java debugger configuration
      require('dap').configurations.java = {
        {
          type = 'java',
          request = 'attach',
          name = 'Debug Java',
          hostName = '127.0.0.1',
          port = 5005,
        },
      }
    end
  }
}
