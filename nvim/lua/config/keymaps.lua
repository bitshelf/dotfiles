-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

vim.keymap.set('n', "<F2>", ":nohlsearch<CR>", { silent = true, desc = "nohlsearch" })
vim.keymap.set('x', "ZQ", "<Esc>:quit<CR>", { silent = true, desc = "visual quit not save" })
vim.keymap.set('x', "ZZ", "<Esc>:wqa<CR>", { silent = true ,desc = "visual quit" })
