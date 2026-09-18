return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mfussenegger/nvim-dap-python",
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
	},
	keys = {
		{
			"<leader>rb",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Debug: Toggle Breakpoint",
		},
		{
			"<leader>rB",
			function()
				require("dap").set_breakpoint(vim.fn.input("断点条件: "))
			end,
			desc = "Debug: Conditional Breakpoint",
		},
		{
			"<leader>rc",
			function()
				require("dap").continue()
			end,
			desc = "Debug: Start or Continue",
		},
		{
			"<leader>rn",
			function()
				require("dap").step_over()
			end,
			desc = "Debug: Step Over",
		},
		{
			"<leader>ri",
			function()
				require("dap").step_into()
			end,
			desc = "Debug: Step Into",
		},
		{
			"<leader>ro",
			function()
				require("dap").step_out()
			end,
			desc = "Debug: Step Out",
		},
		{
			"<leader>rl",
			function()
				require("dap").run_last()
			end,
			desc = "Debug: Run Last",
		},
		{
			"<leader>rr",
			function()
				require("dap").repl.toggle()
			end,
			desc = "Debug: Toggle REPL",
		},
		{
			"<leader>rt",
			function()
				require("dap").terminate()
				require("dapui").close()
			end,
			desc = "Debug: Terminate and Close UI",
		},
		{
			"<leader>ru",
			function()
				require("dapui").toggle()
			end,
			desc = "Debug: Toggle UI",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		local debugpy_python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
		require("dap-python").setup(debugpy_python)

		for _, configuration in ipairs(dap.configurations.python or {}) do
			configuration.console = "integratedTerminal"
		end

		local function reset_dapui()
			-- A DAP pane may have been closed independently, leaving dap-ui with a
			-- stale window id. Rebuild the whole layout before every new session.
			dapui.close()
			dapui.open()
		end

		dap.listeners.before.attach.user_dapui = reset_dapui
		dap.listeners.before.launch.user_dapui = reset_dapui

		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
		vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo", linehl = "Visual" })
	end,
}
