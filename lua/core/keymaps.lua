local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation
keymap("n", "<leader>wh", "<C-w>h", opts)
keymap("n", "<leader>wj", "<C-w>j", opts)
keymap("n", "<leader>wk", "<C-w>k", opts)
keymap("n", "<leader>wl", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<A-h>", ":resize -2<CR>", opts)
keymap("n", "<A-l>", ":resize +2<CR>", opts)
keymap("n", "<A-j>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-k>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<leader><S-l>", ":bnext<CR>", opts)
keymap("n", "<leader><S-h>", ":bprevious<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Don't yank on delete char
keymap("n", "x", '"_x', opts)
keymap("n", "X", '"_X', opts)
keymap("v", "x", '"_x', opts)
keymap("v", "X", '"_X', opts)

keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
