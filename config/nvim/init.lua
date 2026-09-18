require("config.options")
require("config.keymaps")
require("config.autocmds")

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazy_path) then
	local clone_output = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazy_path,
	})
	if vim.v.shell_error ~= 0 then
		error("无法安装 lazy.nvim:\n" .. clone_output)
	end
end
vim.opt.runtimepath:prepend(lazy_path)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
  rocks = { enabled = false },
})
