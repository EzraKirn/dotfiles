return {
  "mfussenegger/nvim-dap",

  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    -- "julianolf/nvim-dap-lldb", -- Optional: Only if you want helper templates (not essential)
  },

  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "codelldb", -- system path from yay
        args = { "--port", "${port}" },
        -- On Windows: uncomment 'detached = false'
      },
    }

    -- C/C++/Rust debug configuration
    for _, lang in ipairs({ "c", "cpp", "rust" }) do
      dap.configurations[lang] = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false, -- Change to false if you prefer not to pause at main()
          args = {},
        },
      }
    end

    vim.fn.sign_define('DapBreakpoint', {
      text = '', -- Change this to your preferred symbol
      texthl = 'DapBreakpoint',
      linehl = '',
      numhl = ''
    })
    vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#FF0000', bold = true })

    -- DAP-UI auto open/close
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

    -- Keymaps
    vim.keymap.set("n", "<leader>d;", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<leader>db", dap.continue, {})
  end,
}
