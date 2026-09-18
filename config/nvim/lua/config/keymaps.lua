local map = vim.keymap.set

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

map("n", "<leader><CR>", "<cmd>nohlsearch<CR>", { desc = "Clear Search Highlight" })
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Save File" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit Window" })
map("n", "<leader>c", "<cmd>bdelete<CR>", { desc = "Close Buffer" })
map("n", "<leader>ev", "<cmd>vsplit ~/.config/nvim/init.lua<CR>", { desc = "Edit Neovim Config" })
map("n", "<leader>so", "<cmd>source %<CR>", { desc = "Reload Current Lua File" })

map("n", "<C-h>", "<C-w>h", { desc = "Focus Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus Right Window" })
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Vertical Split" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Horizontal Split" })
map("n", "<leader>sc", "<cmd>close<CR>", { desc = "Close Split" })
map("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Leave Terminal Mode" })

map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show Diagnostics" })

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
