return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.2",
		cmd = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<C-p>", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
			{ "<C-f>", "<cmd>Telescope live_grep<CR>", desc = "Search Text" },
			{ "<leader>o", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document Symbols" },
			{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Search Text" },
			{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Search Help" },
		},
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		keys = {
			{ "<leader>b", "<cmd>Neotree toggle<CR>", desc = "Toggle File Tree" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},
}
