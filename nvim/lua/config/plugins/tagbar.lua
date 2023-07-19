return {
 --  {
	-- "preservim/tagbar",
	-- config = function()
	--    vim.keymap.set('n', '<LEADER>tb', ":TagbarToggle<cr>" )
	-- end,
 --  }
 {
  "liuchengxu/vista.vim",
	config = function()
	   vim.keymap.set('n', '<LEADER>tb', ":Vista!!<cr>" )
	   vim.g.vista_default_executive = 'ctags'
	   vim.g.vista_icon_indent = {'╰─▸ ', '├─▸ '}
	end,
 }
}
