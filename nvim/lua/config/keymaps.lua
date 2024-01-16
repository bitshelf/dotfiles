local opts = { noremap = true, silent = true, nowait = true }
local keymap = vim.keymap.set

vim.keymap.set('n', "<F2>", ":nohlsearch<CR>", { silent = true, desc = "nohlsearch" })
vim.keymap.set({'n','x'}, "ZQ", "<Esc>:quitall<CR>", { silent = true, desc = "visual quit not save" })
vim.keymap.set({'n','x'}, "ZZ", "<Esc>:wqa<CR>", { silent = true ,desc = "visual quit" })

-- vim.keymap.del('n',"<leader>e")
vim.keymap.del('n',"<leader>L")
vim.keymap.del('n',"<leader>l")
vim.keymap.set('n', '<leader>l', "<cmd>UndotreeToggle<cr>", { desc = "UndotreeToggle", silent = true, nowait = true })
