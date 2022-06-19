local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Save
keymap("n", "<leader>fs", ":w<CR>", opts)

keymap("n", "<leader>gs", ":tab Git<CR>", opts)
-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Trouble Remaps
keymap("n", "gr", "<cmd>Trouble lsp_references<cr>", opts)
keymap("n", "gd", "<cmd>Trouble lsp_definitions<cr>", opts)
keymap("n", "gi", "<cmd>Trouble lsp_implementations<cr>", opts)
keymap("n", "gD", "<cmd>Trouble lsp_type_definitions<cr>", opts)
