return {
	"github/copilot.vim",
	version = "1.*",
	event = { "BufReadPost", "BufNewFile" },
	cmd = "Copilot",
	init = function()
		vim.g.copilot_no_tab_map = true
	end,
	config = function()
		vim.keymap.set("n", "<leader>tc", function()
			local enabled = vim.g.copilot_enabled ~= 0
			vim.cmd(enabled and "Copilot disable" or "Copilot enable")
			vim.notify("Copilot suggestions " .. (enabled and "disabled" or "enabled"))
		end, { desc = "Toggle Copilot Suggestions" })

		vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
			expr = true,
			replace_keycodes = false,
			desc = "Copilot: Accept Suggestion",
		})
	end,
}
