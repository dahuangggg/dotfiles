return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = { "rafamadriz/friendly-snippets" },
	opts = {
		keymap = {
			preset = "default",
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 300,
			},
		},
		signature = { enabled = true },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				lua = { "lsp", "path", "snippets", "buffer" },
				python = { "lsp", "path", "snippets", "buffer" },
				java = { "lsp", "path", "snippets" },
				c = { "lsp", "path", "snippets" },
				cpp = { "lsp", "path", "snippets" },
				markdown = { "path", "snippets", "buffer" },
				text = { "buffer" },
				gitcommit = { "buffer" },
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
