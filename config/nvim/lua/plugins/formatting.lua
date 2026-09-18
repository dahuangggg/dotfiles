return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"stylua",
				"ruff",
				"clang-format",
				"google-java-format",
				"debugpy",
			},
			auto_update = false,
			run_on_start = true,
			start_delay = 1000,
		},
	},
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>lf",
				function()
					require("conform").format({
						async = true,
						lsp_format = "fallback",
					})
				end,
				mode = { "n", "x" },
				desc = "Format File or Selection",
			},
		},
		opts = {
			notify_on_error = true,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				java = { "google-java-format" },
			},
		},
	},
}
