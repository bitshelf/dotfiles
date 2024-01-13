local opts = { noremap = true, silent = true, nowait = true }
local keymap = vim.keymap.set

vim.keymap.set('n', "<F2>", ":nohlsearch<CR>", { silent = true, desc = "nohlsearch" })
vim.keymap.set('x', "ZQ", "<Esc>:quit<CR>", { silent = true, desc = "visual quit not save" })
vim.keymap.set('x', "ZZ", "<Esc>:wqa<CR>", { silent = true ,desc = "visual quit" })
