return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Show Buffer Keymaps",
			},
		},
		opts = {
			preset = "modern",
			spec = {
				{ "<leader>f", group = "Find" },
				{ "<leader>h", group = "Git Hunks" },
				{ "<leader>l", group = "Language" },
				{ "<leader>r", group = "Run and Debug" },
				{ "<leader>s", group = "Splits" },
				{ "<leader>t", group = "Toggle" },
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter")
			treesitter.setup({})

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
				pattern = { "bash", "c", "cpp", "java", "json", "lua", "markdown", "python", "query", "vim", "vimdoc" },
				callback = function(event)
					pcall(vim.treesitter.start, event.buf)
				end,
			})
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "2.*",
		cmd = { "ToggleTerm", "TermExec" },
		keys = {
			{ "<leader>tt", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Toggle Bottom Terminal" },
		},
		opts = {
			size = 12,
			direction = "horizontal",
			start_in_insert = true,
			persist_size = true,
			persist_mode = true,
			close_on_exit = true,
			shade_terminals = true,
		},
	},
}
