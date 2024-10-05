local opts = { noremap = true, silent = true, nowait = true }
-- local keymap = vim.keymap.set

-- vim.keymap.del('n',"<leader>e")
vim.keymap.del('n', "<leader>L")
vim.keymap.del('n', "<leader>l")
vim.keymap.del('n', "<c-/>")
vim.keymap.del('n', "<c-_>")

vim.keymap.set('n', "<F2>", ":nohlsearch<CR>", { silent = true, desc = "nohlsearch" })
vim.keymap.set({'n','x'}, "ZQ", "<cmd>qa!<CR>", { silent = true, desc = "visual quit not save" })
vim.keymap.set({'n','x'}, "ZZ", "<cmd>wqa<CR>", { silent = true ,desc = "visual quit" })
vim.keymap.set('n', '<leader>l', "<cmd>UndotreeToggle<cr>", { desc = "UndotreeToggle", silent = true, nowait = true })

-- vim.api.nvim_set_keymap("n", "<C-_>", "<Cmd>lua require('Comment.api').toggle.linewise.current()<CR>", {})
-- vim.api.nvim_set_keymap("i", "<C-_>", "<Esc>:<C-u>lua require('Comment.api').toggle.linewise.current()<CR>\"_cc", {})
-- vim.api.nvim_set_keymap("v", "<C-_>", "gc", {})
-- vim.api.nvim_set_keymap("n", "<C-/>", "<Cmd>lua require('Comment.api').toggle.linewise.current()<CR>", {})
-- vim.api.nvim_set_keymap("i", "<C-/>", "<Esc>:<C-u>lua require('Comment.api').toggle.linewise.current()<CR>\"_cc", {})
-- vim.api.nvim_set_keymap("v", "<C-/>", "gc", {})
vim.keymap.set({'n','i'}, "<c-/>", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", { noremap = true, silent = true, nowait = true, desc = "Toggle Comment line" })
vim.keymap.set("x", "<c-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { noremap = true, silent = true, nowait = true, desc = "Toggle Comment visualmode" })
vim.keymap.set({'n','i'}, "<c-_>", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", { noremap = true, silent = true, nowait = true, desc = "Toggle Comment line" })
vim.keymap.set("x", "<c-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { noremap = true, silent = true, nowait = true, desc = "Toggle Comment visualmode" })

-- remove lazyvim terminal keybind
vim.keymap.set("t", "<c-h>", "<c-h>", { buffer = buf, nowait = true })
vim.keymap.set("t", "<c-j>", "<c-j>", { buffer = buf, nowait = true })
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]],{ buffer = buf, nowait = true, desc = "Enter Normal Mode" })
vim.keymap.set("t", "<c-k>", "<c-k>", { buffer = buf, nowait = true, desc = "delte after chars" })
vim.keymap.set("t", "<c-l>", "<c-l>", { buffer = buf, nowait = true, desc = "Clear screen" })
-- vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
-- vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
-- vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })

vim.keymap.set("c", "W!", "silent w !sudo tee % >/dev/null", { buffer = buf, nowait = true })
vim.keymap.set("n", "<leader>fT","<cmd>ToggleTerm direction=horizontal<CR>", { buffer = buf, nowait = true })

vim.keymap.set("n", "j", function(...)
  local count = vim.v.count

  if count == 0 then
    return "gj"
  else
    return "j"
  end
end, { expr = true })

vim.keymap.set("n", "k", function(...)
  local count = vim.v.count

  if count == 0 then
    return "gk"
  else
    return "k"
  end
end, { expr = true })

vim.keymap.set("n", "<leader>um", function (...)
  if vim.opt.list:get() then
    vim.cmd("setlocal nolist")
    vim.cmd("DisableWhitespace")
    vim.b.miniindentscope_disable = true
  else
    vim.cmd("setlocal list")
    vim.cmd("EnableWhitespace")
    vim.b.miniindentscope_disable = false
  end
end, {buffer = buf, nowait = true, desc = "Toggle listchars" })
