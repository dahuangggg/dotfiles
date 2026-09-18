return {
  "mason-org/mason-lspconfig.nvim",
  lazy = false,
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
  },
  opts = {
    ensure_installed = {
      "pyright",
      "clangd",
      "jdtls",
      "lua_ls",
    },
    automatic_enable = false,
  },
  config = function(_, opts)
    require("mason-lspconfig").setup(opts)
    require("config.lsp").setup()
  end,
}
