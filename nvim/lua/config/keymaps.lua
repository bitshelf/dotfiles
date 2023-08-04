
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
