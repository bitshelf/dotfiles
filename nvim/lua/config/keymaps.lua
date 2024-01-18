local opts = { noremap = true, silent = true, nowait = true }
local keymap = vim.keymap.set

vim.keymap.set('n', "<F2>", ":nohlsearch<CR>", { silent = true, desc = "nohlsearch" })
vim.keymap.set({'n','x'}, "ZQ", "<cmd>qa!<CR>", { silent = true, desc = "visual quit not save" })
vim.keymap.set({'n','x'}, "ZZ", "<cmd>wqa<CR>", { silent = true ,desc = "visual quit" })
vim.keymap.set('n', '<leader>l', "<cmd>UndotreeToggle<cr>", { desc = "UndotreeToggle", silent = true, nowait = true })

-- vim.keymap.del('n',"<leader>e")
vim.keymap.del('n', "<leader>L")
vim.keymap.del('n', "<leader>l")

-- remove lazyvim terminal keybind
vim.keymap.set("t", "<c-h>", "<c-h>", { buffer = buf, nowait = true })
vim.keymap.set("t", "<c-j>", "<c-j>", { buffer = buf, nowait = true })
vim.keymap.set("t", "<c-k>", "<c-k>", { buffer = buf, nowait = true })
vim.keymap.set("t", "<c-l>", "<c-l>", { buffer = buf, nowait = true })
