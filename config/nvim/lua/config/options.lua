local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings = { "utf-8", "utf-16", "latin1" }

vim.cmd.syntax("on")
opt.termguicolors = true
opt.clipboard = "unnamedplus"

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.list = true
opt.listchars = { tab = "| ", trail = "·", nbsp = "␣" }
opt.scrolloff = 4
opt.breakindent = true
opt.updatetime = 250
opt.foldlevel = 99
opt.foldlevelstart = 99

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.inccommand = "split"

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.cindent = true

opt.runtimepath:append("/opt/homebrew/opt/fzf")
opt.splitright = true
opt.splitbelow = true

local undo_dir = vim.fn.expand("~/.config/nvim/tmp/undo")
vim.fn.mkdir(undo_dir, "p")
opt.undofile = true
opt.undodir = { undo_dir, "." }

opt.mouse = "a"
vim.g.bigfile_size = 1.5 * 1024 * 1024
