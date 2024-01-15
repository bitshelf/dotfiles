
local mode_nv = { "n", "v" }
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local nmappings = {
	-- Movement
	{ from = "J", to = "8j", mode = mode_nv },
}

for _, mapping in ipairs(nmappings) do
	vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true })
end

vim.keymap.set('n', "<F2>", ":nohlsearch<CR>", { desc = "nohlsearch", silent = true })
vim.keymap.set({'n','x'}, "ZQ", "<Esc>:quitall<CR>", opts )
vim.keymap.set({'n','x'}, "ZZ", "<Esc>:wqa<CR>", opts )

-- save buffer
-- keymap("n", "<leader>w", ":w<cr>", { desc = "save and don't quit", silent = true })
keymap("n", "<C-s>", ":w<cr>", opts)

-- Resize with arrows
keymap("n", "<A-Up>", ":resize +2<CR>", opts)
keymap("n", "<A-Down>", ":resize -2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)

-- Move to window using the <ctrl> hjkl keys
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window",  })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window",  })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window",  })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window",  })

-- buffers
keymap("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
keymap("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
keymap("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
keymap("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

--keywordprg
keymap("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
keymap("v", "<", "<gv", { desc = "right" })
keymap("v", ">", ">gv", {desc = "lift" })

keymap("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
keymap("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- tabs
keymap("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
keymap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
keymap("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
keymap("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
keymap("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
keymap("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
