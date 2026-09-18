local M = {}

local methods = vim.lsp.protocol.Methods

local function supports(client, method, bufnr)
	return client:supports_method(method, { bufnr = bufnr })
end

local function map_if_supported(client, method, mode, lhs, rhs, desc, bufnr)
	if supports(client, method, bufnr) then
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. desc })
	end
end

local function configure_buffer(client, bufnr)
	if vim.b[bufnr].bigfile then
		vim.schedule(function()
			vim.lsp.buf_detach_client(bufnr, client.id)
		end)
		return
	end

	map_if_supported(
		client,
		methods.textDocument_definition,
		"n",
		"gd",
		vim.lsp.buf.definition,
		"Go to Definition",
		bufnr
	)
	map_if_supported(client, methods.textDocument_hover, "n", "K", vim.lsp.buf.hover, "Hover Documentation", bufnr)
	map_if_supported(
		client,
		methods.textDocument_implementation,
		"n",
		"gri",
		vim.lsp.buf.implementation,
		"Go to Implementation",
		bufnr
	)
	map_if_supported(
		client,
		methods.textDocument_references,
		"n",
		"grr",
		vim.lsp.buf.references,
		"Find References",
		bufnr
	)
	map_if_supported(
		client,
		methods.textDocument_typeDefinition,
		"n",
		"grt",
		vim.lsp.buf.type_definition,
		"Go to Type Definition",
		bufnr
	)
	map_if_supported(client, methods.textDocument_rename, "n", "grn", vim.lsp.buf.rename, "Rename Symbol", bufnr)
	map_if_supported(
		client,
		methods.textDocument_codeAction,
		{ "n", "x" },
		"gra",
		vim.lsp.buf.code_action,
		"Code Action",
		bufnr
	)
	map_if_supported(
		client,
		methods.textDocument_documentSymbol,
		"n",
		"gO",
		vim.lsp.buf.document_symbol,
		"Document Symbols",
		bufnr
	)
	map_if_supported(client, methods.textDocument_codeLens, "n", "grx", vim.lsp.codelens.run, "Run CodeLens", bufnr)
	map_if_supported(
		client,
		methods.textDocument_signatureHelp,
		"i",
		"<C-s>",
		vim.lsp.buf.signature_help,
		"Signature Help",
		bufnr
	)

	if supports(client, methods.textDocument_definition, bufnr) then
		vim.keymap.set("n", "gD", function()
			local width = vim.api.nvim_win_get_width(0)
			local height = vim.api.nvim_win_get_height(0)
			vim.cmd(width > height * 2 and "vsplit" or "split")
			vim.lsp.buf.definition()
		end, { buffer = bufnr, desc = "LSP: Definition in Split" })
	end

	if supports(client, methods.textDocument_inlayHint, bufnr) then
		vim.keymap.set("n", "<leader>th", function()
			local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
			vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
		end, { buffer = bufnr, desc = "LSP: Toggle Inlay Hints" })
	end

	if supports(client, methods.textDocument_foldingRange, bufnr) then
		for _, winid in ipairs(vim.fn.win_findbuf(bufnr)) do
			vim.api.nvim_set_option_value("foldmethod", "expr", { win = winid })
			vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.lsp.foldexpr()", { win = winid })
		end
	end

	if supports(client, methods.textDocument_documentHighlight, bufnr) then
		local highlight_group = vim.api.nvim_create_augroup("user_lsp_highlight_" .. bufnr, { clear = true })
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = highlight_group,
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			group = highlight_group,
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
		vim.api.nvim_create_autocmd("LspDetach", {
			group = highlight_group,
			buffer = bufnr,
			once = true,
			callback = function()
				vim.lsp.buf.clear_references()
				pcall(vim.api.nvim_del_augroup_by_id, highlight_group)
			end,
		})
	end
end

local function setup_attach_keymaps()
	local group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true })

	vim.api.nvim_create_autocmd("LspAttach", {
		group = group,
		callback = function(event)
			local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
			configure_buffer(client, event.buf)
		end,
	})

	-- JDTLS 等服务器会在启动后动态注册能力；注册完成后补齐对应 Buffer 快捷键。
	local original_handler = vim.lsp.handlers["client/registerCapability"]
	vim.lsp.handlers["client/registerCapability"] = function(err, result, context, config)
		local response = original_handler and original_handler(err, result, context, config) or nil
		local client = vim.lsp.get_client_by_id(context.client_id)
		if client then
			for bufnr in pairs(client.attached_buffers) do
				configure_buffer(client, bufnr)
			end
		end
		return response
	end
end

function M.setup()
	-- 删除 Neovim 全局 LSP 默认映射，随后只为服务器实际支持的能力创建 Buffer 映射。
	for _, mapping in ipairs({
		{ "n", "gra" },
		{ "x", "gra" },
		{ "n", "gri" },
		{ "n", "grn" },
		{ "n", "grr" },
		{ "n", "grt" },
		{ "n", "grx" },
		{ "n", "gO" },
		{ "i", "<C-s>" },
	}) do
		pcall(vim.keymap.del, mapping[1], mapping[2])
	end

	vim.diagnostic.config({
		virtual_text = true,
		virtual_lines = false,
		severity_sort = true,
		float = { source = "if_many", border = "rounded" },
	})

	local servers = { "pyright", "clangd", "jdtls", "lua_ls" }
	for _, server in ipairs(servers) do
		local config_path = vim.fn.stdpath("config") .. "/lsp/" .. server .. ".lua"
		local ok, server_config = pcall(dofile, config_path)
		if not ok then
			error(("无法加载 %s 配置: %s"):format(server, server_config))
		end
		vim.lsp.config(server, server_config)
	end

	vim.lsp.config("*", {
		capabilities = require("blink.cmp").get_lsp_capabilities(),
	})

	setup_attach_keymaps()
	vim.lsp.enable(servers)

	-- init.lua 本身会让 Lua filetype 提前加载，补挂启动参数中的首个 Lua 文件。
	vim.schedule(function()
		for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
			if
				vim.api.nvim_buf_is_loaded(bufnr)
				and vim.bo[bufnr].filetype == "lua"
				and #vim.lsp.get_clients({ bufnr = bufnr, name = "lua_ls" }) == 0
			then
				vim.lsp.start(vim.lsp.config.lua_ls, { bufnr = bufnr })
			end
		end
	end)
end

return M
