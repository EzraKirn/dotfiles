return {
	"mfussenegger/nvim-dap",

	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"julianolf/nvim-dap-lldb",
	},

	opts = {},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- dapui setup
		dapui.setup()

		-- codelldb config
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
				args = { "--port", "${port}" },

				-- On windows you may have to uncomment this:
				-- detached = false,
			},
		}

		-- DAP config
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp

		-- Auto open/close dap-ui
		dap.listeners.before.attach.dapui_config = function() dapui.open() end
		dap.listeners.before.launch.dapui_config = function() dapui.open() end
		dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
		dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

		-- keybinds
		-- vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
		-- vim.keymap.set("n", "<leader>dc", dap.continue, {})
	end,
}
