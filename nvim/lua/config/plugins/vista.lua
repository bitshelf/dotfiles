return {
 --  {
	-- "preservim/tagbar",
	-- config = function()
	--    vim.keymap.set('n', '<leader>tb', ":TagbarToggle<cr>" )
	-- end,
 --  }
 {
  "liuchengxu/vista.vim",
   event = "VeryLazy",
	config = function()
	   vim.keymap.set('n', '<leader>tb', ":Vista!!<cr>" )
	   vim.g.vista_default_executive = 'ctags'
	   -- vim.g.vista_icon_indent = {'╰─▸ ', '├─▸ '}

	   vim.cmd([[
		 let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
	     let g:vista#renderer#enable_icon = 1

	     " The default icons can't be suitable for all the filetypes, you can extend it as you wish.
	     let g:vista#renderer#icons = {
	     \   "function": "\uf794",
	     \   "variable": "\uf71b",
	     \  }

	     let g:vista_fzf_preview = ['right:50%']
	   ]])
	end,
 }
}
