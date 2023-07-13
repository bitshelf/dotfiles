return {
	{
	'neoclide/coc.nvim',
	branch='release',
	lazy = false,
  	priority = 1000,

	config = function()
		-- GoTo code navigation
		local keyset = vim.keymap.set
		local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
		keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
		keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
		keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
		keyset("n", "gr", "<Plug>(coc-references)", {silent = true})
	end
	}
}
