return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.background = "dark"
      vim.cmd.colorscheme("gruvbox")
      vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
      vim.cmd("highlight NormalFloat guibg=NONE ctermbg=NONE")
      vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")
    end,
  },
  { "folke/tokyonight.nvim", lazy = true },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
}
