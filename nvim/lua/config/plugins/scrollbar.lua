return {
  {
	"petertriho/nvim-scrollbar",
	config = function()
		require("scrollbar.handlers.search").setup()
		require("scrollbar").setup({
			show = true,
			handle = {
				text = " ",
				color = "#928374",
				hide_if_all_visible = true,
			},
			marks = {
				Search = { color = "yellow" },
				Misc = { color = "purple" },
			},
			handlers = {
				cursor = false,
				diagnostic = true,
				gitsigns = true,
				handle = true,
				search = true,
			},
		})
	end,
  },
  {
  	"kevinhwang91/nvim-hlslens",
  	-- config = function()
  	-- 	require('hlslens').setup()
  	-- 	local kopts = { noremap = true, silent = true }
  	-- 	vim.api.nvim_set_keymap('n', '=',
  	-- 		[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
  	-- 		kopts)
  	-- 	vim.api.nvim_set_keymap('n', '-',
  	-- 		[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
  	-- 		kopts)
  	-- 	vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
  	-- 	vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
  	-- 	vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
  	-- 	vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
  	-- 	vim.api.nvim_set_keymap('n', '<Leader><CR>', '<Cmd>noh<CR>', kopts)
  	-- end
  },
}
