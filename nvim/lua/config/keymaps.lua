
local mode_nv = { "n", "v" }
local mode_v = { "v" }
local mode_i = { "i" }
local nmappings = {
	-- Movement
	{ from = "J",             to = "8j",                                                                   mode = mode_nv },
}

for _, mapping in ipairs(nmappings) do
	vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true })
end

vim.keymap.set('n', "<F2>", ":nohlsearch<CR>", { silent = true })

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- save buffer
keymap("n", "<leader>w", ":w<cr>", opts)
keymap("n", "<leader>.", ":cd %:p:h<cr>", opts)
keymap("n", "<C-s>", ":w<cr>", opts)

-- Resize with arrows
keymap("n", "<A-Up>", ":resize +2<CR>", opts)
keymap("n", "<A-Down>", ":resize -2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)
